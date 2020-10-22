# Set up logs bucket with read/write permissions
module "emr-logs-bucket" {
  source      = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=0.1.0"
  bucket_name = var.bucket_name_for_logs
  read_write_actions = [
    "s3:HeadBucket",
    "s3:PutObject",
  ]
  read_write_paths = ["logs/hbase-test-cluster"] # r/w policy permitting specified rw actions on entire bucket
}

# Set up root directory bucket
module "emr-rootdir-bucket" {
  source           = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=0.1.0"
  bucket_name      = var.bucket_name_for_root_directory
  read_write_paths = [""] # r/w policy permitting default rw actions on entire bucket
}

# Create new EC2 key pair
resource "tls_private_key" "emr_private_key" {
  algorithm = "RSA"
}

module "emr_key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "hbase-test-emr-key"
  public_key = tls_private_key.emr_private_key.public_key_openssh
}

# EMR Static HBase cluster
module "emr-hbase" {
  # source                         = "git::git@github.com:Datatamer/terraform-aws-emr.git?ref=0.11.0"
  source = "../.."

  # Configurations
  create_static_cluster = true
  release_label         = "emr-5.29.0" # hbase 1.4.10
  applications          = ["Hbase"]
  emr_config_file_path  = "../../modules/aws-emr-emrfs/config.json"
  bucket_path_to_logs   = "logs/hbase-test-cluster"
  additional_tags       = {}
  name_prefix           = "hbase_test"

  # Networking
  subnet_id  = var.subnet_id
  vpc_id     = var.vpc_id
  tamr_cidrs = []
  tamr_sgs   = []

  # External resource references
  bucket_name_for_root_directory = module.emr-rootdir-bucket.bucket_name
  bucket_name_for_logs           = module.emr-logs-bucket.bucket_name
  s3_policy_arns                 = [module.emr-logs-bucket.rw_policy_arn, module.emr-rootdir-bucket.rw_policy_arn]
  key_pair_name                  = module.emr_key_pair.this_key_pair_key_name

  # Scale
  master_group_instance_count = 1
  core_group_instance_count   = 2
  master_instance_type        = "m4.large"
  core_instance_type          = "r5.xlarge"
  master_ebs_size             = 50
  core_ebs_size               = 50
}
