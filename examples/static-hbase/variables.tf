variable "release_label" {
  type        = string
  description = "The release label for the Amazon EMR release."
  default     = "emr-5.29.0" # hbase 1.4.10
}

variable "emr_config_file_path" {
  type        = string
  description = "Path to the EMR JSON configuration file. Please include the file name as well."
  default     = "../../modules/aws-emr-emrfs/config.json"
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to be attached to the resources created"
  default     = {}
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the EMR cluster will be created"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID of the network"
}

variable "key_pair_name" {
  type        = string
  description = "Name of the Key Pair that will be attached to the EC2 instances"
  default     = "tamr-emr-test"
}

variable "tamr_cidrs" {
  type        = list(string)
  description = "List of CIDRs for Tamr"
  default     = []
}

variable "tamr_sgs" {
  type        = list(string)
  description = "Security Group for the Tamr Instance"
  default     = []
}

variable "cluster_name" {
  type        = string
  description = "Name for the EMR cluster to be created"
}

variable "bucket_name_for_root_directory" {
  type        = string
  description = "S3 bucket name for storing root directory."
}

variable "bucket_name_for_logs" {
  type        = string
  description = "S3 bucket name for cluster logs."
}

variable "emrfs_metadata_table_name" {
  type        = string
  description = "Name of the Dynamodb table (already created or to be used for EMR consistent view)"
  default     = "EmrFSMetadata-Hbase-Test"
}

variable "emr_service_role_name" {
  type        = string
  description = "Name for the new iam service role for the EMR cluster"
  default     = "tamr-emr-hbase-service-role-test"
}

variable "emr_ec2_role_name" {
  type        = string
  description = "Name for the new iam role for the EMR EC2 instances"
  default     = "tamr-emr-hbase-ec2-role-test"
}

variable "emr_ec2_instance_profile_name" {
  type        = string
  description = "Name for the new instance profile for the EMR EC2 instances"
  default     = "tamr-emr-hbase-instance-profile-test"
}

variable "emr_service_iam_policy_name" {
  type        = string
  description = "Name for the IAM policy attached to the EMR Service role"
  default     = "test-hbase-service-policy"
}

variable "emr_ec2_iam_policy_name" {
  type        = string
  description = "Name for the IAM policy attached to the EMR service role"
  default     = "test-hbase-ec2-policy"
}

variable "master_instance_group_name" {
  type        = string
  description = "Name for the master instance group"
  default     = "MasterInstanceGroup-Hbase-Test"
}

variable "core_instance_group_name" {
  type        = string
  description = "Name for the core instance group"
  default     = "CoreInstanceGroup-Hbase-Test"
}

variable "emr_managed_master_sg_name" {
  type        = string
  description = "Name for the EMR managed master security group"
  default     = "Test-TAMR-EMR-Hbase-Master"
}

variable "emr_managed_core_sg_name" {
  type        = string
  description = "Name for the EMR managed core security group"
  default     = "Test-TAMR-EMR-Hbase-Core"
}

variable "emr_additional_master_sg_name" {
  type        = string
  description = "Name for the EMR additional master security group"
  default     = "Test-TAMR-EMR-Hbase-Additional-Master"
}

variable "emr_additional_core_sg_name" {
  type        = string
  description = "Name for the EMR additional core security group"
  default     = "Test-TAMR-EMR-Hbase-Additional-Core"
}

variable "emr_service_access_sg_name" {
  type        = string
  description = "Name for the EMR service access security group"
  default     = "Test-TAMR-EMR-Hbase-Service-Access"
}
