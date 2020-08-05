resource "aws_s3_bucket" "emr_hbase_logs_s3_bucket" {
  bucket        = var.bucket_name_for_logs
  acl           = "private"
  force_destroy = true
  tags          = var.additional_tags
}

resource "aws_s3_bucket" "emr_hbase_rootdir_s3_bucket" {
  bucket        = var.bucket_name_for_hbase_root_dir
  acl           = "private"
  force_destroy = true
  tags          = var.additional_tags
  logging {
    target_bucket = aws_s3_bucket.emr_hbase_logs_s3_bucket.id
    target_prefix = var.data_bucket_logging_prefix
  }
}
