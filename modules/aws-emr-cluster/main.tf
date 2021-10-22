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
    additional_master_security_groups = join(",", [for s in var.emr_managed_master_sg_ids : s])
    emr_managed_slave_security_group  = var.emr_managed_core_sg_id
    additional_slave_security_groups  = join(",", [for s in var.emr_managed_core_sg_ids : s])
    service_access_security_group     = length(var.emr_service_access_sg_ids) > 0 ? element(var.emr_service_access_sg_ids, 0) : null
    instance_profile                  = var.emr_ec2_instance_profile_arn
    key_name                          = var.key_pair_name
  }

  master_instance_fleet {
    name                      = var.master_instance_fleet_name
    target_on_demand_capacity = var.master_instance_on_demand_count
    target_spot_capacity      = var.master_instance_spot_count
    instance_type_configs {
      bid_price                                  = var.master_bid_price
      bid_price_as_percentage_of_on_demand_price = var.master_bid_price_as_percentage_of_on_demand_price
      instance_type                              = var.master_instance_type
      weighted_capacity                          = 1
      ebs_config {
        size                 = var.master_ebs_size
        type                 = var.master_ebs_type
        volumes_per_instance = var.master_ebs_volumes_count
      }
    }
    dynamic "launch_specifications" {
      for_each = var.master_instance_spot_count > 0 ? [1] : []
      content {
        spot_specification {
          allocation_strategy      = "capacity-optimized"
          block_duration_minutes   = var.master_block_duration_minutes
          timeout_action           = var.master_timeout_action
          timeout_duration_minutes = var.master_timeout_duration_minutes
        }
      }
    }
  }

  core_instance_fleet {
    name                      = var.core_instance_fleet_name
    target_on_demand_capacity = var.core_instance_on_demand_count
    target_spot_capacity      = var.core_instance_spot_count
    instance_type_configs {
      bid_price                                  = var.core_bid_price
      bid_price_as_percentage_of_on_demand_price = var.core_bid_price_as_percentage_of_on_demand_price
      instance_type                              = var.core_instance_type
      weighted_capacity                          = 1
      ebs_config {
        size                 = var.core_ebs_size
        type                 = var.core_ebs_type
        volumes_per_instance = var.core_ebs_volumes_count
      }
    }
    dynamic "launch_specifications" {
      for_each = var.core_instance_spot_count > 0 ? [1] : []
      content {
        spot_specification {
          allocation_strategy      = "capacity-optimized"
          block_duration_minutes   = var.core_block_duration_minutes
          timeout_action           = var.core_timeout_action
          timeout_duration_minutes = var.core_timeout_duration_minutes
        }
      }
    }
  }

  log_uri      = "s3n://${var.bucket_name_for_logs}/${var.bucket_path_to_logs}"
  service_role = var.emr_service_role_arn

  dynamic "bootstrap_action" {
    for_each = var.bootstrap_actions
    content {
      name = bootstrap_action.value["name"]
      path = bootstrap_action.value["path"]
      args = bootstrap_action.value["args"]
    }
  }

  custom_ami_id = var.custom_ami_id

  # Upload HBase/Hadoop configuration to s3
  step {
    action_on_failure = "TERMINATE_CLUSTER"
    name              = "Sync HBase/Hadoop configuration to S3"

    hadoop_jar_step {
      jar = "command-runner.jar" # Native to AMI for running script using AWS CLI
      args = [
        "bash",
        "-c",
        " aws s3 cp s3://${var.bucket_name_for_root_directory}/${var.utility_script_bucket_key} ./upload_hbase_config.sh; chmod +x upload_hbase_config.sh; ./upload_hbase_config.sh${contains(local.applications, "hbase") ? " hbase" : ""}"
      ]
    }
  }

  # Optional: ignore outside changes to running cluster steps
  lifecycle {
    ignore_changes = [step]
  }

  tags = var.tags
}

data "aws_instance" "master" {

  filter {
    name   = "tag:aws:elasticmapreduce:job-flow-id"
    values = [one(aws_emr_cluster.emr-cluster[*].id)]
  }

  filter {
    name   = "tag:aws:elasticmapreduce:instance-group-role"
    values = ["MASTER"]
  }
}
