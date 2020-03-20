variable "aws_account_id" {
  type = string
  description = "Account ID of the AWS account"
}

variable "vpc_id" {
  type = string
  description = "VPC id of the network"
}

variable "key_pair_name" {
  type = string
  description = "Name of the Key Pair that will be attached to the EC2 instances"
}

variable "subnet_id" {
  type = string
  description = "ID of the subnet where the emr cluster will be created"
}

variable "emr_hbase_config_file_path" {
  type = string
  description = "Path to the EMR Hbase config file. Please include the file name as well."
}

variable "bucket_name_for_logs" {
  type = string
  description = "S3 bucket name for EMR Hbase logs"
}

variable "bucket_name_for_hbase_root_dir" {
  type = string
  description = "S3 bucket name for EMR Hbase root directory"
}

variable "cluster_name" {
  type = string
  description = "Name for the EMR Hbase cluster to be created"
  default = "TAMR-EMR-Hbase-Cluster"
}

variable "tamr_cidrs" {
  type        = list(string)
  description = "List of CIDRs for Tamr"
  default = []
}

variable "tamr_sgs" {
  type = list(string)
  description = "Security Groups for the Tamr Instance"
  default = []
}

variable "emrfs_metadata_table_name" {
  type = string
  description = "Table name of EMRFS metadata table in Dynamodb"
  default = "EmrFSMetadata"
}

variable "emrfs_metadata_read_capacity" {
  type = number
  description = "Read capacity units of the dynamodb table used for EMRFS metadata"
  default = 600
}

variable "emrfs_metadata_write_capacity" {
  type = number
  description = "Write capacity units of the dynamodb table used for EMRFS metadata"
  default = 300
}

variable "additional_tags" {
  type = map(string)
  description = "Additional tags to be attached to the resources created"
  default = {}
}

variable "aws_region_of_dynamodb_table" {
  type = string
  description = "AWS region where the Dynamodb table for EMRFS metadata is located"
  default = "us-east-1"
}

variable "emr_service_role_name" {
  type = string
  description = "Name for the new iam service role for the EMR Hbase cluster"
  default = "tamr_emr_service_role"
}

variable "emr_ec2_role_name" {
  type = string
  description = "Name for the new iam role for the EMR Hbase EC2 instances"
  default = "tamr_emr_ec2_role"
}

variable "emr_ec2_instance_profile_name" {
  type = string
  description = "Name for the new instance profile for the EMR Hbase EC2 instances"
  default = "tamr_emr_ec2_instance_profile"
}

variable "master_instance_group_name" {
  type = string
  description = "Name for the master instance group"
  default = "MasterInstanceGroup"
}

variable "core_instance_group_name" {
  type = string
  description = "Name for the core instance group"
  default = "CoreInstanceGroup"
}

variable "release_label" {
  type = string
  description = "The release label for the Amazon EMR release."
  default = "emr-5.11.2"
}

variable "master_instance_type" {
  type = string
  description = "The EC2 instance type of the master nodes"
  default = "m4.xlarge"
}

variable "core_instance_type" {
  type = string
  description = "The EC2 instance type of the core nodes"
  default = "m4.xlarge"
}

variable "master_group_instance_count" {
  type = number
  default = 1
  description = "Number of instances for the master instance group. Must be 1 or 3."
}

variable "core_group_instance_count" {
  type = number
  default = 1
  description = "Number of Amazon EC2 instances used to execute the job flow"
}

variable "emr_managed_master_sg_name" {
  type = string
  description = "Name for the EMR managed master security group"
  default = "TAMR-EMR-Master"
}

variable "emr_managed_core_sg_name" {
  type = string
  description = "Name for the EMR managed core security group"
  default = "TAMR-EMR-Core"
}

variable "emr_additional_master_sg_name" {
  type = string
  description = "Name for the EMR additional master security group"
  default = "TAMR-EMR-Master-Additional"
}

variable "emr_additional_core_sg_name" {
  type = string
  description = "Name for the EMR additional core security group"
  default = "TAMR-EMR-Core-Additional"
}

variable "emr_service_access_sg_name" {
  type = string
  description = "Name for the EMR service access security group"
  default = "TAMR-EMR-Service-Access"
}

variable "emr_service_iam_policy_name" {
  type = string
  description = "Name for the IAM policy attached to the EMR Service role"
  default = "tamr-emr-hbase-policy"
}

variable "emr_ec2_iam_policy_name" {
  type = string
  description = "Name for the IAM policy attached to the EMR Service role"
  default = "tamr-emr-ec2-policy"
}
