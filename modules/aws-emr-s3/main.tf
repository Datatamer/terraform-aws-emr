resource "aws_s3_bucket" "emr_hbase_logs_s3_bucket" {
  bucket = var.bucket_name_for_logs
  acl    = "private"
  tags = var.additional_tags
}

resource "aws_s3_bucket" "emr_hbase_rootdir_s3_bucket" {
  bucket = var.bucket_name_for_hbase_root_dir
  acl    = "private"
  tags = var.additional_tags
}
