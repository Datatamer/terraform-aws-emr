module "emr-hbase-s3" {
  source                         = "./modules/aws-emr-s3"
  bucket_name_for_hbase_root_dir = var.bucket_name_for_hbase_root_dir
  bucket_name_for_logs           = var.bucket_name_for_logs
  additional_tags                = var.additional_tags
}

module "emr-hbase-sgs" {
  source                        = "./modules/aws-emr-sgs"
  emr_managed_master_sg_name    = var.emr_managed_master_sg_name
  emr_managed_core_sg_name      = var.emr_managed_core_sg_name
  emr_additional_master_sg_name = var.emr_additional_master_sg_name
  emr_additional_core_sg_name   = var.emr_additional_core_sg_name
  emr_service_access_sg_name    = var.emr_service_access_sg_name
  vpc_id                        = var.vpc_id
  tamr_cidrs                    = var.tamr_cidrs
  tamr_sgs                      = var.tamr_sgs
  additional_tags               = var.additional_tags
}

module "emr-hbase-iam" {
  source                                  = "./modules/aws-emr-iam"
  aws_account_id                          = var.aws_account_id
  s3_bucket_name_for_hbase_logs           = module.emr-hbase-s3.s3_bucket_name_for_logs
  s3_bucket_name_for_hbase_root_directory = module.emr-hbase-s3.s3_bucket_name_for_hbase_rootdir
  emrfs_metadata_table_name               = var.emrfs_metadata_table_name
  aws_region_of_dynamodb_table            = var.aws_region_of_dynamodb_table
  emr_ec2_iam_policy_name                 = var.emr_ec2_iam_policy_name
  emr_service_iam_policy_name             = var.emr_service_iam_policy_name
  emr_service_role_name                   = var.emr_service_role_name
  emr_ec2_instance_profile_name           = var.emr_ec2_instance_profile_name
  emr_ec2_role_name                       = var.emr_ec2_role_name
  additional_tags                         = var.additional_tags
}

module "emr-hbase-cluster" {
  source                            = "./modules/aws-emr-hbase"
  additional_master_security_groups = module.emr-hbase-sgs.emr_additional_master_sg_id
  additional_slave_security_groups  = module.emr-hbase-sgs.emr_additional_core_sg_id
  emr_hbase_s3_bucket_logs          = module.emr-hbase-s3.s3_bucket_name_for_logs
  emr_hbase_s3_bucket_root_dir      = module.emr-hbase-s3.s3_bucket_name_for_hbase_rootdir
  emr_managed_master_security_group = module.emr-hbase-sgs.emr_managed_master_sg_id
  emr_managed_slave_security_group  = module.emr-hbase-sgs.emr_managed_core_sg_id
  instance_profile                  = module.emr-hbase-iam.emr_ec2_instance_profile_arn
  key_name                          = var.key_pair_name
  name                              = var.cluster_name
  path_to_config_file               = var.emr_hbase_config_file_path
  service_access_security_group     = module.emr-hbase-sgs.emr_service_access_sg_id
  service_role                      = module.emr-hbase-iam.emr_service_role_arn
  subnet_id                         = var.subnet_id
  emrfs_metadata_read_capacity      = var.emrfs_metadata_read_capacity
  emrfs_metadata_write_capacity     = var.emrfs_metadata_write_capacity
  emrfs_metadata_table_name         = var.emrfs_metadata_table_name
  core_group_instance_count         = var.core_group_instance_count
  core_instance_group_name          = var.core_instance_group_name
  core_instance_type                = var.core_instance_type
  master_group_instance_count       = var.master_group_instance_count
  master_instance_group_name        = var.master_instance_group_name
  master_instance_type              = var.master_instance_type
  release_label                     = var.release_label
  tags                              = var.additional_tags
}
