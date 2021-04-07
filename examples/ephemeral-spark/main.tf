# Set up logs bucket with read/write permissions
module "emr-logs-bucket" {
  source      = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=0.1.3"
  bucket_name = var.bucket_name_for_logs
  read_write_actions = [
    "s3:HeadBucket",
    "s3:PutObject",
  ]
  read_write_paths = [""] # r/w policy permitting specified rw actions on entire bucket
}

# Set up root directory bucket
module "emr-rootdir-bucket" {
  source           = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=0.1.3"
  bucket_name      = var.bucket_name_for_root_directory
  read_write_paths = [""] # r/w policy permitting default rw actions on entire bucket
}

module "ephemeral-spark-sgs" {
  # source                        = "git::git@github.com:Datatamer/terraform-aws-emr.git//modules/aws-emr-sgs?ref=2.0.0"
  source                        = "../../modules/aws-emr-sgs"
  applications                  = ["Spark"]
  vpc_id                        = var.vpc_id
  emr_managed_master_sg_name    = "Ephem-Spark-Test-EMR-Spark-Master"
  emr_managed_core_sg_name      = "Ephem-Spark-Test-EMR-Spark-Core"
  emr_additional_master_sg_name = "Ephem-Spark-Test-EMR-Spark-Additional-Master"
  emr_additional_core_sg_name   = "Ephem-Spark-Test-EMR-Spark-Additional-Core"
  emr_service_access_sg_name    = "Ephem-Spark-Test-EMR-Spark-Service-Access"
}

module "ephemeral-spark-iam" {
  # source                            = "git::git@github.com:Datatamer/terraform-aws-emr.git//modules/aws-emr-iam?ref=2.0.0"
  source                            = "../../modules/aws-emr-iam"
  s3_bucket_name_for_logs           = module.emr-logs-bucket.bucket_name
  s3_bucket_name_for_root_directory = module.emr-rootdir-bucket.bucket_name
  s3_policy_arns                    = [module.emr-logs-bucket.rw_policy_arn, module.emr-rootdir-bucket.rw_policy_arn]
  emr_ec2_iam_policy_name           = "ephem-spark-test-ec2-policy"
  emr_service_iam_policy_name       = "ephem-spark-test-service-policy"
  emr_service_role_name             = "ephem-spark-test-service-role"
  emr_ec2_instance_profile_name     = "ephem-spark-test-instance-profile"
  emr_ec2_role_name                 = "ephem-spark-test-ec2-role"
}

module "ephemeral-spark-config" {
  # source                        = "git::git@github.com:Datatamer/terraform-aws-emr.git//modules/aws-emr-config?ref=2.0.0"
  source                         = "../../modules/aws-emr-config"
  create_static_cluster          = false
  cluster_name                   = "" # unused
  emr_config_file_path           = "../emr-config-template.json"
  bucket_name_for_root_directory = module.emr-rootdir-bucket.bucket_name
}
