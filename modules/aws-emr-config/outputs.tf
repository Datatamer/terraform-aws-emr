locals {
  emr_config = var.create_static_cluster && length(aws_s3_bucket_object.upload_hbase_config_script) > 0
}

output "emr_configuration_json" {
  value       = local.json_config
  description = "EMR cluster configuration in JSON format"
}

output "upload_config_script_s3_key" {
  value       = local.emr_config ? aws_s3_bucket_object.upload_hbase_config_script[0].key : ""
  description = "The name of the upload config script object in the bucket."
}

output "hbase_config_path" {
  value       = var.hbase_config_path
  description = "Path in the root directory bucket that HBase config was uploaded to"
}
