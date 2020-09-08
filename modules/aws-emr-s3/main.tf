resource "aws_s3_bucket" "emr_hbase_logs_s3_bucket" {
  bucket = var.bucket_name_for_logs
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  force_destroy = true
  tags          = var.additional_tags
}

resource "aws_s3_bucket_policy" "logs_bucket_policy" {
  bucket = aws_s3_bucket.emr_hbase_logs_s3_bucket.id
  policy = templatefile(
    "${path.module}/bucket_policy.json",
    { bucket_name = aws_s3_bucket.emr_hbase_logs_s3_bucket.id }
  )
}

resource "aws_s3_bucket" "emr_hbase_rootdir_s3_bucket" {
  bucket = var.bucket_name_for_hbase_root_dir
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  force_destroy = true
  tags          = var.additional_tags
}

resource "aws_s3_bucket_policy" "rootdir_bucket_policy" {
  bucket = aws_s3_bucket.emr_hbase_rootdir_s3_bucket.id
  policy = templatefile(
    "${path.module}/bucket_policy.json",
    { bucket_name = aws_s3_bucket.emr_hbase_rootdir_s3_bucket.id }
  )
}
