locals {
  json_config = templatefile(
    var.emr_config_file_path,
    {
      emr_hbase_s3_bucket_root_dir = var.bucket_name_for_root_directory
    }
  )
}

# JSON configuration to S3
resource "aws_s3_bucket_object" "upload_json_config" {
  bucket                 = var.bucket_name_for_root_directory
  key                    = var.json_configuration_bucket_key
  content                = local.json_config
  content_type           = "application/json"
  server_side_encryption = "AES256"
}

# Script for uploading HBase/Hadoop configuration to S3
resource "aws_s3_bucket_object" "upload_hbase_config_script" {
  count  = var.create_static_cluster ? 1 : 0
  bucket = var.bucket_name_for_root_directory
  key    = var.utility_script_bucket_key
  content = templatefile(
    "${path.module}/upload_hbase_config.sh",
    {
      bucket_name_for_root_directory = var.bucket_name_for_root_directory
      hbase_config_path              = var.hbase_config_path
      hadoop_config_path             = var.hadoop_config_path
    }
  )
  server_side_encryption = "AES256"
}
