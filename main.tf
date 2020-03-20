module "emr-hbase-s3" {
  source = "git::https://github.com/Datatamer/terraform-emr-hbase.git//modules/aws-emr-s3?ref=v0.1.0"
  bucket_name_for_hbase_root_dir = var.bucket_name_for_hbase_root_dir
  bucket_name_for_logs = var.bucket_name_for_logs
}

module "emr-hbase-sgs" {
  source = "git::https://github.com/Datatamer/terraform-emr-hbase.git//modules/aws-emr-sgs?ref=v0.1.0"
  vpc_id = var.vpc_id
}

module "emr-hbase-iam" {
  source = "git::https://github.com/Datatamer/terraform-emr-hbase.git//modules/aws-emr-iam?ref=v0.1.0"
  aws_account_id = var.aws_account_id
  s3_bucket_name_for_hbase_logs = var.bucket_name_for_logs
  s3_bucket_name_for_hbase_root_directory = var.bucket_name_for_hbase_root_dir
}

module "emr-hbase-cluster" {
  source = "git::https://github.com/Datatamer/terraform-emr-hbase.git//modules/aws-emr-hbase?ref=v0.1.0"
  additional_master_security_groups = module.emr-hbase-sgs.emr_additional_master_sg_id
  additional_slave_security_groups = module.emr-hbase-sgs.emr_additional_agent_sg_id
  emr_hbase_s3_bucket_logs = var.bucket_name_for_logs
  emr_hbase_s3_bucket_root_dir = var.bucket_name_for_hbase_root_dir
  emr_managed_master_security_group = module.emr-hbase-sgs.emr_managed_master_sg_id
  emr_managed_slave_security_group = module.emr-hbase-sgs.emr_managed_agent_sg_id
  instance_profile = module.emr-hbase-iam.emr_ec2_instance_profile_arn
  key_name = var.key_pair_name
  name = "hbase-cluster-from-repo"
  path_to_config_file = "git::https://github.com/Datatamer/terraform-emr-hbase.git//modules/aws-emr-hbase/config.json?ref=v0.1.0"
  service_access_security_group = module.emr-hbase-sgs.emr_service_access_sg_id
  service_role = module.emr-hbase-iam.emr_service_role_arn
  subnet_id = var.subnet_id
}
