locals {
  this_application = ["Spark"]
}

# Set up logs bucket with read/write permissions
module "emr-logs-bucket" {
  source      = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=1.1.0"
  bucket_name = var.bucket_name_for_logs
  read_write_actions = [
    "s3:HeadBucket",
    "s3:PutObject",
  ]
  read_write_paths = [""] # r/w policy permitting specified rw actions on entire bucket
  tags             = var.tags
}

# Set up root directory bucket
module "emr-rootdir-bucket" {
  source           = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=1.1.0"
  bucket_name      = var.bucket_name_for_root_directory
  read_write_paths = [""] # r/w policy permitting default rw actions on entire bucket
  tags             = var.tags
}

# Create new EC2 key pair
resource "tls_private_key" "emr_private_key" {
  algorithm = "RSA"
}

module "emr_key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  version    = "1.0.0"
  key_name   = "spark-test-emr-key"
  public_key = tls_private_key.emr_private_key.public_key_openssh
  tags       = var.tags
}

# EMR Static Spark cluster
module "emr-spark" {
  # source = "git::git@github.com:Datatamer/terraform-aws-emr.git?ref=6.0.0"
  source = "../.."

  # Configurations
  create_static_cluster = true
  release_label         = "emr-5.29.0" # spark 2.4.4
  applications          = local.this_application
  emr_config_file_path  = "../emr-config-template.json"
  tags                  = var.tags

  # Networking
  subnet_id  = var.subnet_id
  vpc_id     = var.vpc_id

  # External resource references
  bucket_name_for_root_directory = module.emr-rootdir-bucket.bucket_name
  bucket_name_for_logs           = module.emr-logs-bucket.bucket_name
  s3_policy_arns                 = [module.emr-logs-bucket.rw_policy_arn, module.emr-rootdir-bucket.rw_policy_arn]
  bucket_path_to_logs            = "logs/spark-test-cluster/"
  key_pair_name                  = module.emr_key_pair.key_pair_key_name

  # Names
  cluster_name                  = "Spark-Test-EMR-Cluster"
  emr_service_role_name         = "spark-test-service-role"
  emr_ec2_role_name             = "spark-test-ec2-role"
  emr_ec2_instance_profile_name = "spark-test-instance-profile"
  emr_service_iam_policy_name   = "spark-test-service-policy"
  emr_ec2_iam_policy_name       = "spark-test-ec2-policy"
  master_instance_fleet_name    = "Spark-Test-MasterInstanceFleet"
  core_instance_fleet_name      = "Spark-Test-CoreInstanceFleet"
  emr_managed_master_sg_name    = "Spark-Test-EMR-Spark-Master"
  emr_managed_core_sg_name      = "Spark-Test-EMR-Spark-Core"

  # Scale
  master_instance_on_demand_count = 1
  core_instance_on_demand_count   = 2
  master_instance_type            = "m4.large"
  core_instance_type              = "r5.xlarge"
  master_ebs_size                 = 50
  core_ebs_size                   = 50

  # Security Group IDs
  emr_managed_master_sg_ids = module.aws-emr-sg-master.security_group_ids
  emr_managed_core_sg_ids = module.aws-emr-sg-core.security_group_ids
}

module "sg-ports" {
  # source               = "git::https://github.com/Datatamer/terraform-aws-emr.git//modules/aws-emr-ports?ref=6.0.0"
  source = "../../modules/aws-emr-ports"
  applications = local.this_application
}

module "aws-emr-sg-master" {
  source = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id = var.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
  egress_cidr_blocks = var.egress_cidr_blocks
  ingress_ports  = module.sg-ports.ingress_master_ports
  sg_name_prefix = var.master_name_prefix
  egress_protocol = "all"
  ingress_protocol = "tcp"
}

module "aws-emr-sg-core" {
  source = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id = var.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
  egress_cidr_blocks = var.egress_cidr_blocks
  ingress_ports  = module.sg-ports.ingress_core_ports
  sg_name_prefix = var.core_name_prefix
  egress_protocol = "all"
  ingress_protocol = "tcp"
}
