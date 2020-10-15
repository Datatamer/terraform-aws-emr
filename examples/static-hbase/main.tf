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
  # source                         = "git::git@github.com:Datatamer/terraform-aws-emr.git?ref=0.10.4"
  source = "../.."

  # Configurations
  create_static_cluster = true
  release_label         = "emr-5.29.0" # hbase 1.4.10
  applications          = ["Hbase"]
  emr_config_file_path  = "../../modules/aws-emr-emrfs/config.json"
  additional_tags       = {}

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

  # Names
  cluster_name                  = "HBase-Test-EMR-Cluster"
  emrfs_metadata_table_name     = "HBase-Test-EmrFSMetadata"
  emr_service_role_name         = "hbase-test-service-role"
  emr_ec2_role_name             = "hbase-test-ec2-role"
  emr_ec2_instance_profile_name = "hbase-test-instance-profile"
  emr_service_iam_policy_name   = "hbase-test-service-policy"
  emr_ec2_iam_policy_name       = "hbase-test-ec2-policy"
  master_instance_group_name    = "HBase-Test-MasterInstanceGroup"
  core_instance_group_name      = "Hbase-Test-CoreInstanceGroup"
  emr_managed_master_sg_name    = "HBase-Test-EMR-Hbase-Master"
  emr_managed_core_sg_name      = "HBase-Test-EMR-Hbase-Core"
  emr_additional_master_sg_name = "HBase-Test-EMR-Hbase-Additional-Master"
  emr_additional_core_sg_name   = "HBase-Test-EMR-Hbase-Additional-Core"
  emr_service_access_sg_name    = "HBase-Test-EMR-Hbase-Service-Access"

  # Scale
  master_group_instance_count = 1
  core_group_instance_count   = 2
  master_instance_type        = "m4.large"
  core_instance_type          = "r5.xlarge"
  master_ebs_size             = 50
  core_ebs_size               = 50
}
