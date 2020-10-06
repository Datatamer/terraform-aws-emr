variable "emr_service_role_name" {
  type        = string
  description = "Name for the new iam service role for the EMR Hbase cluster"
  default     = "tamr_emr_service_role"
}

variable "emr_ec2_role_name" {
  type        = string
  description = "Name for the new iam role for the EMR Hbase EC2 instances"
  default     = "tamr_emr_ec2_role"
}

variable "emr_ec2_instance_profile_name" {
  type        = string
  description = "Name for the new instance profile for the EMR Hbase EC2 instances"
  default     = "tamr_emr_ec2_instance_profile"
}

variable "s3_policy_arns" {
  type        = list(string)
  description = "List of policy ARNs to attach to EMR EC2 instance profile."
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to be attached to the resources created"
  default     = {}
}

variable "s3_bucket_name_for_hbase_root_directory" {
  type        = string
  description = "S3 Bucket name of the hbase root directory"
}

variable "aws_region_of_dynamodb_table" {
  type        = string
  description = "AWS region where the Dynamodb table for EMRFS metadata is located"
  default     = "us-east-1"
}

variable "emrfs_metadata_table_name" {
  type        = string
  description = "Table name of EMRFS metadata table in Dynamodb"
  default     = "EmrFSMetadata"
}

variable "s3_bucket_name_for_hbase_logs" {
  type        = string
  description = "S3 bucket name/directory of EMR Hbase logs"
}

variable "emr_service_iam_policy_name" {
  type        = string
  description = "Name for the IAM policy attached to the EMR Service role"
  default     = "tamr-emr-hbase-policy"
}

variable "emr_ec2_iam_policy_name" {
  type        = string
  description = "Name for the IAM policy attached to the EMR Service role"
  default     = "tamr-emr-ec2-policy"
}
