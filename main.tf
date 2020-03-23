module "emr-hbase-s3" {
  source = "./modules/aws-emr-s3"
  bucket_name_for_hbase_root_dir = var.bucket_name_for_hbase_root_dir
  bucket_name_for_logs = var.bucket_name_for_logs
}

module "emr-hbase-sgs" {
  source = "./modules/aws-emr-sgs"
  vpc_id = var.vpc_id
}

module "emr-hbase-iam" {
  source = "./modules/aws-emr-iam"
  aws_account_id = var.aws_account_id
  s3_bucket_name_for_hbase_logs = module.emr-hbase-s3.s3_bucket_name_for_logs
  s3_bucket_name_for_hbase_root_directory = module.emr-hbase-s3.s3_bucket_name_for_hbase_rootdir
}

module "emr-hbase-cluster" {
  source = "./modules/aws-emr-hbase"
  additional_master_security_groups = module.emr-hbase-sgs.emr_additional_master_sg_id
  additional_slave_security_groups = module.emr-hbase-sgs.emr_additional_agent_sg_id
  emr_hbase_s3_bucket_logs = module.emr-hbase-s3.s3_bucket_name_for_logs
  emr_hbase_s3_bucket_root_dir = module.emr-hbase-s3.s3_bucket_name_for_hbase_rootdir
  emr_managed_master_security_group = module.emr-hbase-sgs.emr_managed_master_sg_id
  emr_managed_slave_security_group = module.emr-hbase-sgs.emr_managed_agent_sg_id
  instance_profile = module.emr-hbase-iam.emr_ec2_instance_profile_arn
  key_name = var.key_pair_name
  name = "hbase-cluster-from-repo"
  path_to_config_file = "modules/aws-emr-hbase/config.json"
  service_access_security_group = module.emr-hbase-sgs.emr_service_access_sg_id
  service_role = module.emr-hbase-iam.emr_service_role_arn
  subnet_id = var.subnet_id
}
