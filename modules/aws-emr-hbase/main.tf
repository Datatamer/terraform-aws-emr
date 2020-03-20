#
# EMR Cluster Resources
#

data "template_file" "load_file_to_upload" {
  template = file(var.path_to_config_file)
  vars = {
    emrfs_metadata_read_capacity = var.emrfs_metadata_read_capacity
    emrfs_metadata_write_capacity = var.emrfs_metadata_write_capacity
    emrfs_metadata_table_name = var.emrfs_metadata_table_name
    emr_hbase_s3_bucket_root_dir = var.emr_hbase_s3_bucket_root_dir
  }
}

resource "aws_s3_bucket_object" "upload_config" {
  bucket = var.emr_hbase_s3_bucket_root_dir
  key = "config.json"
  content = data.template_file.load_file_to_upload.rendered
  content_type = "application/json"
}

resource "aws_emr_cluster" "emr-hbase" {
  name          = var.name
  release_label = var.release_label
  applications = [
    "Hbase",
  ]
  configurations = data.template_file.load_file_to_upload.rendered

  ec2_attributes {
    subnet_id                         = var.subnet_id
    emr_managed_master_security_group = var.emr_managed_master_security_group
    additional_master_security_groups = var.additional_master_security_groups
    emr_managed_slave_security_group  = var.emr_managed_slave_security_group
    additional_slave_security_groups  = var.additional_slave_security_groups
    service_access_security_group     = var.service_access_security_group
    instance_profile                  = var.instance_profile
    key_name                          = var.key_name
  }


  master_instance_group {
    name          = var.master_instance_group_name
    instance_type = var.master_instance_type
    # NOTE: value must be 1 or 3
    instance_count = var.master_group_instance_count
  }
  core_instance_group {
    name           = var.core_instance_group_name
    instance_type  = var.core_instance_type
    instance_count = var.core_group_instance_count
  }

  log_uri      = "s3n://${var.emr_hbase_s3_bucket_logs}/"
  service_role = var.service_role

  # Optional: ignore outside changes to running cluster steps
  lifecycle {
    ignore_changes = ["step"]
  }

  tags = merge(var.tags, {Name = var.name})
}
