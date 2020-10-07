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

# EMR Static HBase cluster
module "emr-hbase" {
  # source                         = "git::git@github.com:Datatamer/terraform-aws-emr.git?ref=0.10.0"
  source = "../.."

  # Configurations
  create_static_cluster = true
  release_label         = var.release_label
  applications          = ["Hbase"]
  emr_config_file_path  = var.emr_config_file_path
  additional_tags       = var.additional_tags

  # Networking
  subnet_id     = var.subnet_id
  vpc_id        = var.vpc_id
  key_pair_name = var.key_pair_name
  tamr_cidrs    = var.tamr_cidrs
  tamr_sgs      = var.tamr_sgs

  # Names
  cluster_name                   = var.cluster_name
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

  # Scale
  master_group_instance_count = 1
  core_group_instance_count   = 2
  master_instance_type        = "m4.large"
  core_instance_type          = "r5.xlarge"
  master_ebs_size             = 50
  core_ebs_size               = 50
}
