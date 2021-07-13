# Set up logs bucket with read/write permissions
module "emr-logs-bucket" {
  source      = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=1.1.0"
  bucket_name = var.bucket_name_for_logs
  read_write_actions = [
    "s3:HeadBucket",
    "s3:PutObject",
  ]
  read_write_paths = ["logs/hbase-test-cluster"] # r/w policy permitting specified rw actions on entire bucket
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
  key_name   = "hbase-test-emr-key"
  public_key = tls_private_key.emr_private_key.public_key_openssh
  tags       = var.tags
}

resource "aws_s3_bucket_object" "sample_bootstrap_script" {
  bucket                 = module.emr-rootdir-bucket.bucket_name
  key                    = "bootstrap-actions/downloadarchive.sh"
  source                 = "./downloadarchive.sh"
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "sample_bootstrap_script_2" {
  bucket                 = module.emr-rootdir-bucket.bucket_name
  key                    = "bootstrap-actions/catS3file.sh"
  source                 = "./catS3file.sh"
  server_side_encryption = "AES256"
}

# EMR Static HBase cluster
module "emr-hbase" {
  # source = "git::git@github.com:Datatamer/terraform-aws-emr.git?ref=5.0.0"
  source = "../.."

  # Configurations
  create_static_cluster         = true
  release_label                 = "emr-5.29.0" # hbase 1.4.10
  applications                  = ["Hbase"]
  emr_config_file_path          = "../emr-config-template.json"
  bucket_path_to_logs           = "logs/hbase-test-cluster/"
  json_configuration_bucket_key = "tamr/emr/emr.json"
  utility_script_bucket_key     = "tamr/emr/upload_config.sh"
  tags                          = var.tags
  bootstrap_actions = [
    {
      name = "sample_bootstrap_action",
      path = "s3://${module.emr-rootdir-bucket.bucket_name}/${aws_s3_bucket_object.sample_bootstrap_script.id}"
      args = []
    },
    {
      name = "sample_bootstrap_action_2",
      path = "s3://${module.emr-rootdir-bucket.bucket_name}/${aws_s3_bucket_object.sample_bootstrap_script_2.id}"
      args = ["README"]
    }
  ]

  # Networking
  subnet_id  = var.subnet_id
  vpc_id     = var.vpc_id

  # External resource references
  bucket_name_for_root_directory = module.emr-rootdir-bucket.bucket_name
  bucket_name_for_logs           = module.emr-logs-bucket.bucket_name
  s3_policy_arns                 = [module.emr-logs-bucket.rw_policy_arn, module.emr-rootdir-bucket.rw_policy_arn]
  key_pair_name                  = module.emr_key_pair.key_pair_key_name

  # Names
  cluster_name                  = "HBase-Test-EMR-Cluster"
  emr_service_role_name         = "hbase-test-service-role"
  emr_ec2_role_name             = "hbase-test-ec2-role"
  emr_ec2_instance_profile_name = "hbase-test-instance-profile"
  emr_service_iam_policy_name   = "hbase-test-service-policy"
  emr_ec2_iam_policy_name       = "hbase-test-ec2-policy"
  master_instance_fleet_name    = "HBase-Test-MasterInstanceFleet"
  core_instance_fleet_name      = "Hbase-Test-CoreInstanceFleet"
  emr_managed_master_sg_name    = "HBase-Test-EMR-Hbase-Master"
  emr_managed_core_sg_name      = "HBase-Test-EMR-Hbase-Core"

  # Scale
  master_instance_on_demand_count = 1
  core_instance_on_demand_count   = 2
  master_instance_type            = "m4.large"
  core_instance_type              = "r5.xlarge"
  master_ebs_size                 = 50
  core_ebs_size                   = 50

  # Spot Instance definition
  # on-demand r5.xlarge EC2 + EMR --> $0.252 + $0.063 = $0.315 per Hour
  # core_bid_price = ".100"

  # Don't use spot instances for the master nodes
  master_bid_price = ""

  # Security Group IDs
  emr_managed_master_sg_ids = module.aws-emr-sg-master.security_group_ids
  emr_managed_core_sg_ids = module.aws-emr-sg-core.security_group_ids
}

module "sg-ports" {
  # source               = "git::https://github.com/Datatamer/terraform-aws-emr.git//modules/aws-emr-ports?ref=5.0.0"
  source = "../../modules/aws-emr-ports"
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
