locals {
  applications = [for app in var.applications : lower(app)]
}

data "aws_s3_bucket_object" "json_config" {
  bucket = var.bucket_name_for_root_directory
  key    = var.json_configuration_bucket_key
}

resource "aws_emr_cluster" "emr-cluster" {
  count               = var.create_static_cluster ? 1 : 0
  name                = var.cluster_name
  release_label       = var.release_label
  applications        = local.applications
  configurations_json = data.aws_s3_bucket_object.json_config.body

  ec2_attributes {
    subnet_id                         = var.subnet_id
    emr_managed_master_security_group = var.emr_managed_master_sg_id
    additional_master_security_groups = var.emr_additional_master_sg_id
    emr_managed_slave_security_group  = var.emr_managed_core_sg_id
    additional_slave_security_groups  = var.emr_additional_core_sg_id
    service_access_security_group     = var.emr_service_access_sg_id
    instance_profile                  = var.emr_ec2_instance_profile_arn
    key_name                          = var.key_pair_name
  }


  master_instance_group {
    name          = var.master_instance_group_name
    instance_type = var.master_instance_type
    # NOTE: value must be 1 or 3
    instance_count = var.master_group_instance_count
    ebs_config {
      size                 = var.master_ebs_size
      type                 = var.master_ebs_type
      volumes_per_instance = var.master_ebs_volumes_count
    }
  }
  core_instance_group {
    name           = var.core_instance_group_name
    instance_type  = var.core_instance_type
    instance_count = var.core_group_instance_count
    ebs_config {
      size                 = var.core_ebs_size
      type                 = var.core_ebs_type
      volumes_per_instance = var.core_ebs_volumes_count
    }
  }

  log_uri      = "s3n://${var.bucket_name_for_logs}/"
  service_role = var.emr_service_role_arn

  security_configuration = var.security_configuration_name

  # Upload HBase/Hadoop configuration to s3
  step {
    action_on_failure = "TERMINATE_CLUSTER"
    name              = "Sync HBase/Hadoop configuration to S3"

    hadoop_jar_step {
      jar = "command-runner.jar" # Native to AMI for running script using AWS CLI
      args = [
        "bash",
        "-c",
        " aws s3 cp s3://${var.bucket_name_for_root_directory}/util/upload_hbase_config.sh .; chmod +x upload_hbase_config.sh; ./upload_hbase_config.sh${contains(local.applications, "hbase") ? " hbase" : ""}"
      ]
    }
  }

  # Optional: ignore outside changes to running cluster steps
  lifecycle {
    ignore_changes = [step]
  }

  tags = var.additional_tags
}
