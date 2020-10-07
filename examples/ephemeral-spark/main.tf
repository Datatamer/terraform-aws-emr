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

# Ephemeral Spark cluster
module "emr-ephemeral-spark" {
  # source                         = "git::git@github.com:Datatamer/terraform-aws-emr.git?ref=0.10.0"
  source = "../.."

  # Configurations
  create_static_cluster = false
  release_label         = var.release_label
  applications          = ["Spark"]
  emr_config_file_path  = var.emr_config_file_path
  additional_tags       = var.additional_tags

  # Networking
  vpc_id     = var.vpc_id
  subnet_id  = var.subnet_id
  tamr_cidrs = var.tamr_cidrs


  # Names
  key_pair_name                  = var.key_pair_name
  bucket_name_for_root_directory = module.emr-rootdir-bucket.bucket_name
  bucket_name_for_logs           = module.emr-logs-bucket.bucket_name
  s3_policy_arns                 = [module.emr-logs-bucket.rw_policy_arn, module.emr-rootdir-bucket.rw_policy_arn]
  emrfs_metadata_table_name      = var.emrfs_metadata_table_name
  emr_service_role_name          = var.emr_service_role_name
  emr_ec2_role_name              = var.emr_ec2_role_name
  emr_ec2_instance_profile_name  = var.emr_ec2_instance_profile_name
  emr_service_iam_policy_name    = var.emr_service_iam_policy_name
  emr_ec2_iam_policy_name        = var.emr_ec2_iam_policy_name
  master_instance_group_name     = var.master_instance_group_name
  core_instance_group_name       = var.core_instance_group_name
  emr_managed_master_sg_name     = var.emr_managed_master_sg_name
  emr_managed_core_sg_name       = var.emr_managed_core_sg_name
  emr_additional_master_sg_name  = var.emr_additional_master_sg_name
  emr_additional_core_sg_name    = var.emr_additional_core_sg_name
  emr_service_access_sg_name     = var.emr_service_access_sg_name
}
