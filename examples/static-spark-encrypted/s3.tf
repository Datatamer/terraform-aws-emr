# Set up logs bucket with read/write permissions
module "emr-logs-bucket" {
  source      = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=1.1.1"
  bucket_name = var.bucket_name_for_logs
  read_write_actions = [
    "s3:HeadBucket",
    "s3:PutObject",
  ]
  read_write_paths = [""] # r/w policy permitting specified rw actions on entire bucket
  tags             = var.tags
}

# Set up root directory bucket
module "emr-rootdir-bucket" {
  source           = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=1.1.1"
  bucket_name      = var.bucket_name_for_root_directory
  read_write_paths = [""] # r/w policy permitting default rw actions on entire bucket
  tags             = var.tags
}

resource "aws_s3_bucket_object" "sample_bootstrap_script" {
  depends_on = [local_file.postfix_config]

  bucket                 = module.emr-rootdir-bucket.bucket_name
  key                    = "bootstrap-actions/cloudwatch-install.sh"
  source                 = "${path.module}/tempfiles/cloudwatch-install.sh"
  server_side_encryption = "AES256"
}
