locals {
  this_application = ["Hbase"]
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

# EMR Static HBase cluster
module "emr-hbase" {
  # source = "git::git@github.com:Datatamer/terraform-aws-emr.git?ref=6.2.0"
  source = "../.."

  # Configurations
  create_static_cluster         = true
  release_label                 = "emr-5.33.0" # hbase 1.4.13
  applications                  = local.this_application
  emr_config_file_path          = "../emr-config-template.json"
  bucket_path_to_logs           = "logs/hbase-test-cluster/"
  json_configuration_bucket_key = "tamr/emr/emr.json"
  utility_script_bucket_key     = "tamr/emr/upload_config.sh"
  tags                          = var.tags
  abac_valid_tags               = var.abac_valid_tags
  bootstrap_actions = [
    {
      name = "cw_agent_install",
      path = "s3://${module.emr-rootdir-bucket.bucket_name}/${aws_s3_bucket_object.sample_bootstrap_script.id}"
      args = []
    }
  ]

  # Networking
  subnet_id = var.compute_subnet_id
  vpc_id    = var.vpc_id

  # External resource references
  bucket_name_for_root_directory = module.emr-rootdir-bucket.bucket_name
  bucket_name_for_logs           = module.emr-logs-bucket.bucket_name
  s3_policy_arns = [module.emr-logs-bucket.rw_policy_arn,
    module.emr-rootdir-bucket.rw_policy_arn,
  "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"]
  key_pair_name = module.emr_key_pair.key_pair_key_name

  # Names
  cluster_name                  = format("%s-%s", var.name_prefix, "HBase-Test-EMR-Cluster")
  emr_service_role_name         = format("%s-%s", var.name_prefix, "hbase-test-service-role")
  emr_ec2_role_name             = format("%s-%s", var.name_prefix, "hbase-test-ec2-role")
  emr_ec2_instance_profile_name = format("%s-%s", var.name_prefix, "hbase-test-instance-profile")
  emr_service_iam_policy_name   = format("%s-%s", var.name_prefix, "hbase-test-service-policy")
  emr_ec2_iam_policy_name       = format("%s-%s", var.name_prefix, "hbase-test-ec2-policy")
  master_instance_fleet_name    = format("%s-%s", var.name_prefix, "HBase-Test-MasterInstanceFleet")
  core_instance_fleet_name      = format("%s-%s", var.name_prefix, "Hbase-Test-CoreInstanceFleet")
  emr_managed_master_sg_name    = format("%s-%s", var.name_prefix, "HBase-Test-EMR-Hbase-Master")
  emr_managed_core_sg_name      = format("%s-%s", var.name_prefix, "HBase-Test-EMR-Hbase-Core")
  emr_service_access_sg_name    = format("%s-%s", var.name_prefix, "HBase-Test-EMR-Hbase-Service-Access")

  # Scale
  master_instance_on_demand_count = 1
  core_instance_on_demand_count   = 2
  master_instance_type            = "m6g.xlarge"
  core_instance_type              = "r6g.xlarge"
  master_ebs_size                 = 50
  core_ebs_size                   = 50

  # Security Group IDs
  emr_managed_master_sg_ids = module.aws-emr-sg-master.security_group_ids
  emr_managed_core_sg_ids   = module.aws-emr-sg-core.security_group_ids
  emr_service_access_sg_ids = module.aws-emr-sg-service-access.security_group_ids
}
