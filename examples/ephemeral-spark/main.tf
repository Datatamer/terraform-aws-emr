# Set up logs bucket with read/write permissions
module "emr-logs-bucket" {
  source      = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=1.3.2"
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
  source           = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=1.3.2"
  bucket_name      = var.bucket_name_for_root_directory
  read_write_paths = [""] # r/w policy permitting default rw actions on entire bucket
  tags             = var.tags
}

module "ephemeral-spark-sgs" {
  # source              = "git::git@github.com:Datatamer/terraform-aws-emr.git//modules/aws-emr-sgs?ref=9.0.0"
  source                    = "../../modules/aws-emr-sgs"
  vpc_id                    = var.vpc_id
  emr_managed_sg_name       = format("%s-%s", var.name_prefix, "Ephem-Spark-Test-EMR-Spark-Internal")
  emr_service_access_sg_ids = []

  tags = var.tags
}

module "ephemeral-spark-iam" {
  # source                            = "git::git@github.com:Datatamer/terraform-aws-emr.git//modules/aws-emr-iam?ref=9.0.0"
  source = "../../modules/aws-emr-iam"

  vpc_id                        = var.vpc_id
  s3_bucket_name_for_logs       = module.emr-logs-bucket.bucket_name
  additional_policy_arns        = [module.emr-logs-bucket.rw_policy_arn, module.emr-rootdir-bucket.rw_policy_arn]
  emr_service_iam_policy_name   = format("%s-%s", var.name_prefix, "ephem-spark-test-svc-policy")
  emr_service_role_name         = format("%s-%s", var.name_prefix, "ephem-spark-test-svc-role")
  emr_ec2_instance_profile_name = format("%s-%s", var.name_prefix, "ephem-spark-test-instance-profile")
  emr_ec2_role_name             = format("%s-%s", var.name_prefix, "ephem-spark-test-ec2-role")
  tags                          = var.tags
  abac_valid_tags               = var.abac_valid_tags
}

module "ephemeral-spark-config" {
  # source                        = "git::git@github.com:Datatamer/terraform-aws-emr.git//modules/aws-emr-config?ref=9.0.0"
  source                         = "../../modules/aws-emr-config"
  create_static_cluster          = false
  emr_config_file_path           = "${path.module}/../emr-config-template.json"
  bucket_name_for_root_directory = module.emr-rootdir-bucket.bucket_name
}
