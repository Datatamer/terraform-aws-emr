variable "create_static_cluster" {
  type        = bool
  description = "True if the module should create a static cluster. False if the module should create supporting infrastructure but not the cluster itself."
  default     = true
}

variable "applications" {
  type        = list(string)
  description = "List of applications to run on EMR"
}

variable "bucket_name_for_logs" {
  type        = string
  description = "S3 bucket name for cluster logs."
}

variable "bucket_name_for_root_directory" {
  type        = string
  description = "S3 bucket name for storing root directory."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID of the network"
}

variable "key_pair_name" {
  type        = string
  description = "Name of the Key Pair that will be attached to the EC2 instances"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the EMR cluster will be created"
}

variable "cluster_name" {
  type        = string
  description = "Name for the EMR cluster to be created"
}

variable "emr_config_file_path" {
  type        = string
  description = "Path to the EMR JSON configuration file. Please include the file name as well."
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

variable "emrfs_metadata_table_name" {
  type        = string
  description = "Name of the Dynamodb table (already created or to be used for EMR consistent view)"
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to be attached to the resources created"
  default     = {}
}

variable "aws_region_of_dynamodb_table" {
  type        = string
  description = "AWS Region for the EMRFS Metadata Dynamodb table"
  default     = "us-east-1"
}

variable "emr_service_role_name" {
  type        = string
  description = "Name for the new iam service role for the EMR cluster"
  default     = "tamr_emr_service_role"
}

variable "emr_ec2_role_name" {
  type        = string
  description = "Name for the new iam role for the EMR EC2 instances"
  default     = "tamr_emr_ec2_role"
}

variable "emr_ec2_instance_profile_name" {
  type        = string
  description = "Name for the new instance profile for the EMR EC2 instances"
  default     = "tamr_emr_ec2_instance_profile"
}
