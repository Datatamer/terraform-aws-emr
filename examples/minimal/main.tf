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

# EMR HBase cluster
module "emr-hbase" {
  # source                         = "git::git@github.com:Datatamer/terraform-aws-emr.git?ref=0.9.0"
  source                         = "../.."
  create_static_cluster          = var.create_static_cluster
  applications                   = var.applications
  bucket_name_for_root_directory = module.emr-rootdir-bucket.bucket_name
  bucket_name_for_logs           = module.emr-logs-bucket.bucket_name
  s3_policy_arns                 = [module.emr-logs-bucket.rw_policy_arn, module.emr-rootdir-bucket.rw_policy_arn]
  key_pair_name                  = var.key_pair_name
  subnet_id                      = var.subnet_id
  vpc_id                         = var.vpc_id
  cluster_name                   = var.cluster_name
  emr_config_file_path           = "../../modules/aws-emr-emrfs/config.json"
  tamr_sgs                       = var.tamr_sgs
  tamr_cidrs                     = var.tamr_cidrs
  emrfs_metadata_table_name      = var.emrfs_metadata_table_name
  additional_tags                = var.additional_tags
}
