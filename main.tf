locals {
  applications = [for app in var.applications : lower(app)]
}

module "emr-sgs" {
  source                        = "./modules/aws-emr-sgs"
  applications                  = local.applications
  emr_managed_master_sg_name    = "${var.name_prefix}_emr_managed_master_sg"
  emr_managed_core_sg_name      = "${var.name_prefix}_emr_managed_core_sg"
  emr_additional_master_sg_name = "${var.name_prefix}_emr_additional_master_sg"
  emr_additional_core_sg_name   = "${var.name_prefix}_emr_additional_core_sg"
  emr_service_access_sg_name    = "${var.name_prefix}_emr_service_access_sg"
  vpc_id                        = var.vpc_id
  tamr_cidrs                    = var.tamr_cidrs
  tamr_sgs                      = var.tamr_sgs
  enable_http_port              = var.enable_http_port
  additional_tags               = var.additional_tags
}

module "emr-iam" {
  source                            = "./modules/aws-emr-iam"
  s3_bucket_name_for_logs           = var.bucket_name_for_logs
  s3_bucket_name_for_root_directory = var.bucket_name_for_root_directory
  s3_policy_arns                    = var.s3_policy_arns
  emrfs_metadata_table_name         = "${var.name_prefix}_emrfs_metadata_table"
  aws_region_of_dynamodb_table      = var.aws_region_of_dynamodb_table
  emr_ec2_iam_policy_name           = "${var.name_prefix}_emr_ec2_iam_policy"
  emr_service_iam_policy_name       = "${var.name_prefix}_emr_service_iam_policy"
  emr_service_role_name             = "${var.name_prefix}_emr_service_role"
  emr_ec2_instance_profile_name     = "${var.name_prefix}_emr_ec2_instance_profile"
  emr_ec2_role_name                 = "${var.name_prefix}_emr_ec2_role"
  additional_tags                   = var.additional_tags
}

module "emrfs-dynamodb" {
  source                        = "./modules/aws-emr-emrfs"
  create_static_cluster         = var.create_static_cluster
  emrfs_metadata_read_capacity  = var.emrfs_metadata_read_capacity
  emrfs_metadata_write_capacity = var.emrfs_metadata_write_capacity
  emrfs_metadata_table_name     = "${var.name_prefix}_emrfs_metadata_table"
  tags                          = var.additional_tags
}

module "emr-cluster-config" {
  source                         = "./modules/aws-emr-config"
  create_static_cluster          = var.create_static_cluster
  cluster_name                   = "${var.name_prefix}_emr_cluster"
  emr_config_file_path           = var.emr_config_file_path
  emrfs_metadata_read_capacity   = var.emrfs_metadata_read_capacity
  emrfs_metadata_write_capacity  = var.emrfs_metadata_write_capacity
  emrfs_metadata_table_name      = "${var.name_prefix}_emrfs_metadata_table"
  bucket_name_for_root_directory = var.bucket_name_for_root_directory
  hbase_config_path              = var.hbase_config_path
  hadoop_config_path             = var.hadoop_config_path
}

module "emr-cluster" {
  source = "./modules/aws-emr-cluster"

  # Cluster configuration
  create_static_cluster          = var.create_static_cluster
  cluster_name                   = "${var.name_prefix}_emr_cluster"
  release_label                  = var.release_label
  security_configuration_name    = module.emr-cluster-config.security_configuration_name
  json_configuration_bucket_key  = module.emr-cluster-config.json_config_s3_key
  applications                   = local.applications
  bucket_name_for_root_directory = var.bucket_name_for_root_directory
  bucket_name_for_logs           = var.bucket_name_for_logs
  bucket_path_to_logs            = var.bucket_path_to_logs

  # Cluster instances
  subnet_id                   = var.subnet_id
  key_pair_name               = var.key_pair_name
  master_instance_group_name  = "${var.name_prefix}_master_instance_group"
  master_instance_type        = var.master_instance_type
  master_group_instance_count = var.master_group_instance_count
  master_ebs_volumes_count    = var.master_ebs_volumes_count
  master_ebs_type             = var.master_ebs_type
  master_ebs_size             = var.master_ebs_size
  core_instance_group_name    = "${var.name_prefix}_core_instance_group"
  core_instance_type          = var.core_instance_type
  core_group_instance_count   = var.core_group_instance_count
  core_ebs_volumes_count      = var.core_ebs_volumes_count
  core_ebs_type               = var.core_ebs_type
  core_ebs_size               = var.core_ebs_size

  # Security groups
  emr_managed_master_sg_id    = module.emr-sgs.emr_managed_master_sg_id
  emr_additional_master_sg_id = module.emr-sgs.emr_additional_master_sg_id
  emr_managed_core_sg_id      = module.emr-sgs.emr_managed_core_sg_id
  emr_additional_core_sg_id   = module.emr-sgs.emr_additional_core_sg_id
  emr_service_access_sg_id    = module.emr-sgs.emr_service_access_sg_id

  # IAM
  emr_service_role_arn         = module.emr-iam.emr_service_role_arn
  emr_ec2_instance_profile_arn = module.emr-iam.emr_ec2_instance_profile_arn

  # Note: Value not used in module, but need this to establish dependency on aws-emr-emrfs submodule
  emrfs_metadata_table_name = module.emrfs-dynamodb.emrfs_dynamodb_table_name

  additional_tags = var.additional_tags
}
