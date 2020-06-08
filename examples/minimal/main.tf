module "emr-hbase" {
  source                         = "git::git@github.com:Datatamer/terraform-template-repo.git?ref=0.4.0"
  aws_account_id                 = var.aws_account_id
  bucket_name_for_hbase_root_dir = var.bucket_name_for_hbase_root_dir
  bucket_name_for_logs           = var.bucket_name_for_logs
  key_pair_name                  = var.key_pair_name
  subnet_id                      = var.subnet_id
  vpc_id                         = var.vpc_id
  cluster_name                   = "emr-hbase-cluster-for-tamr-test"
  emr_hbase_config_file_path     = "../modules/aws-emr-hbase/config.json"
  tamr_sgs                       = var.tamr_sgs
  tamr_cidrs                     = var.tamr_cidrs
  emrfs_metadata_table_name      = var.emrfs_metadata_table_name
  additional_tags                = var.additional_tags
}
