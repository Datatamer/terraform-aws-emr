variable "release_label" {
  type        = string
  description = "The release label for the Amazon EMR release."
  default     = "emr-5.29.0" # spark 2.4.4
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

variable "vpc_id" {
  type        = string
  description = "VPC ID of the network"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the EMR cluster will be created"
}

variable "tamr_cidrs" {
  type        = list(string)
  description = "List of CIDRs for Tamr"
  default     = []
}

variable "key_pair_name" {
  type        = string
  description = "Name of the Key Pair that will be attached to the EC2 instances"
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
  default     = "tamr-ephem-spark-emrfs-metadata"
}

variable "emr_service_role_name" {
  type        = string
  description = "Name for the new iam service role for the EMR cluster"
  default     = "tamr-ephem-spark-service-role"
}

variable "emr_ec2_role_name" {
  type        = string
  description = "Name for the new iam role for the EMR EC2 instances"
  default     = "tamr-ephem-spark-ec2-role"
}

variable "emr_ec2_instance_profile_name" {
  type        = string
  description = "Name for the new instance profile for the EMR EC2 instances"
  default     = "tamr-ephem-spark-instance-profile"
}

variable "emr_service_iam_policy_name" {
  type        = string
  description = "Name for the IAM policy attached to the EMR Service role"
  default     = "tamr-ephem-spark-policy-service"
}

variable "emr_ec2_iam_policy_name" {
  type        = string
  description = "Name for the IAM policy attached to the EMR service role"
  default     = "tamr-ephem-spark-policy-ec2"
}

variable "master_instance_group_name" {
  type        = string
  description = "Name for the master instance group"
  default     = "tamr-ephem-spark-master-instance-group"
}

variable "core_instance_group_name" {
  type        = string
  description = "Name for the core instance group"
  default     = "tamr-ephem-spark-core-instance-group"
}

variable "emr_managed_master_sg_name" {
  type        = string
  description = "Name for the EMR managed master security group"
  default     = "tamr-ephem-spark-sg-master"
}

variable "emr_managed_core_sg_name" {
  type        = string
  description = "Name for the EMR managed core security group"
  default     = "tamr-ephem-spark-sg-core"
}

variable "emr_additional_master_sg_name" {
  type        = string
  description = "Name for the EMR additional master security group"
  default     = "tamr-ephem-spark-sg-master-additional"
}

variable "emr_additional_core_sg_name" {
  type        = string
  description = "Name for the EMR additional core security group"
  default     = "tamr-ephem-spark-sg-core-additional"
}

variable "emr_service_access_sg_name" {
  type        = string
  description = "Name for the EMR service access security group"
  default     = "tamr-ephem-spark-sg-service-access"
}
