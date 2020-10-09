# Set up logs bucket with read/write permissions
module "emr-logs-bucket" {
  source      = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=0.1.0"
  bucket_name = var.bucket_name_for_logs
  read_write_actions = [
    "s3:HeadBucket",
    "s3:PutObject",
  ]
  read_write_paths = [""] # r/w policy permitting specified rw actions on entire bucket
}

# Set up root directory bucket
module "emr-rootdir-bucket" {
  source           = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=0.1.0"
  bucket_name      = var.bucket_name_for_root_directory
  read_write_paths = [""] # r/w policy permitting default rw actions on entire bucket
}

# Set up infrastructure for ephemeral Spark cluster
module "emr-ephemeral-spark" {
  # source                         = "git::git@github.com:Datatamer/terraform-aws-emr.git?ref=0.10.0"
  source = "../.."

  # Configurations
  create_static_cluster = false
  release_label         = "emr-5.29.0" # spark 2.4.4
  applications          = ["Spark"]
  emr_config_file_path  = "../../modules/aws-emr-emrfs/config.json"
  additional_tags       = {}

  # Networking
  vpc_id     = var.vpc_id
  subnet_id  = "" # unused
  tamr_cidrs = []
  tamr_sgs   = []

  # External resource references
  bucket_name_for_root_directory = module.emr-rootdir-bucket.bucket_name
  bucket_name_for_logs           = module.emr-logs-bucket.bucket_name
  s3_policy_arns                 = [module.emr-logs-bucket.rw_policy_arn, module.emr-rootdir-bucket.rw_policy_arn]
  key_pair_name                  = ""

  # Names
  cluster_name                  = "" # unused
  emrfs_metadata_table_name     = "Ephem-Spark-Test-EmrFSMetadata"
  emr_service_role_name         = "ephem-spark-test-service-role"
  emr_ec2_role_name             = "ephem-spark-test-ec2-role"
  emr_ec2_instance_profile_name = "ephem-spark-test-instance-profile"
  emr_service_iam_policy_name   = "ephem-spark-test-service-policy"
  emr_ec2_iam_policy_name       = "ephem-spark-test-ec2-policy"
  master_instance_group_name    = "" # unused
  core_instance_group_name      = "" # unused
  emr_managed_master_sg_name    = "Ephem-Spark-Test-EMR-Spark-Master"
  emr_managed_core_sg_name      = "Ephem-Spark-Test-EMR-Spark-Core"
  emr_additional_master_sg_name = "Ephem-Spark-Test-EMR-Spark-Additional-Master"
  emr_additional_core_sg_name   = "Ephem-Spark-Test-EMR-Spark-Additional-Core"
  emr_service_access_sg_name    = "Ephem-Spark-Test-EMR-Spark-Service-Access"
}
