output "s3_bucket_name_for_logs" {
  value = aws_s3_bucket.emr_hbase_logs_s3_bucket.id
  description = "S3 bucket name for EMR logs"
}

output "s3_bucket_name_for_hbase_rootdir" {
  value = aws_s3_bucket.emr_hbase_rootdir_s3_bucket.id
  description = "S3 bucket name for EMR Hbase root directory"
}
