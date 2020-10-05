# Set up logs bucket with read/write permissions
module "emr-logs-bucket" {
  source           = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=0.1.0"
  bucket_name      = var.bucket_name_for_logs
  read_write_paths = [""] # r/w policy on entire bucket
  read_write_actions = [
    "s3:Get*",
    "s3:List*",
    "s3:PutObject",
    "s3:PutObjectTagging"
  ]
}

# Set up root directory bucket
module "emr-rootdir-bucket" {
  source      = "git::git@github.com:Datatamer/terraform-aws-s3.git//modules/encrypted-bucket?ref=0.1.0"
  bucket_name = var.bucket_name_for_hbase_root_dir
}

# EMR HBase cluster
module "emr-hbase" {
  source                         = "git::git@github.com:Datatamer/terraform-aws-emr.git?ref=0.9.0"
  bucket_name_for_hbase_root_dir = module.emr-rootdir-bucket.bucket_name
  bucket_name_for_logs           = module.emr-logs-bucket.bucket_name
  key_pair_name                  = var.key_pair_name
  subnet_id                      = var.subnet_id
  vpc_id                         = var.vpc_id
  cluster_name                   = "emr-hbase-cluster-for-tamr-test"
  emr_hbase_config_file_path     = "../../modules/aws-emr-emrfs/config.json"
  tamr_sgs                       = var.tamr_sgs
  tamr_cidrs                     = var.tamr_cidrs
  emrfs_metadata_table_name      = var.emrfs_metadata_table_name
  additional_tags                = var.additional_tags
}

# Policy Binding
resource "aws_iam_role_policy_attachment" "emr_logs_policy_binding" {
  role       = module.emr-hbase.emr_service_role_name
  policy_arn = module.emr-logs-bucket.rw_policy_arn
}
