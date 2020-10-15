output "emr_config_file_path" {
  value       = var.emr_config_file_path
  description = "Path to the EMR JSON configuration file that was uploaded to S3."
}

output "json_config_s3_key" {
  value       = aws_s3_bucket_object.upload_json_config.key
  description = "The name of the json configuration object in the bucket."
}

output "upload_config_script_s3_key" {
  value       = var.create_static_cluster ? aws_s3_bucket_object.upload_hbase_config_script[0].key : ""
  description = "The name of the upload config script object in the bucket."
}

output "security_configuration_name" {
  value       = var.create_static_cluster ? aws_emr_security_configuration.security_configuration[0].name : ""
  description = "Name of the EMR cluster's security configuration"
}
