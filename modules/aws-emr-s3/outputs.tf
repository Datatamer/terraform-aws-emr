output "s3_bucket_name_for_logs" {
  value       = var.create_new_logs_bucket ? aws_s3_bucket.emr_hbase_logs_s3_bucket[0].id : data.aws_s3_bucket.hbase_logs[0].bucket
  description = "S3 bucket name for EMR logs"
}

output "s3_bucket_name_for_hbase_rootdir" {
  value       = var.create_new_rootdir_bucket ? aws_s3_bucket.emr_hbase_rootdir_s3_bucket[0].id : data.aws_s3_bucket.hbase_rootdir[0].bucket
  description = "S3 bucket name for EMR Hbase root directory"
}
