variable "emr_service_role_name" {
  type        = string
  description = "Name of the new IAM service role for the EMR cluster"
  default     = "tamr_emr_service_role"
}

variable "emr_ec2_role_name" {
  type        = string
  description = "Name of the new IAM role for EMR EC2 instances"
  default     = "tamr_emr_ec2_role"
}

variable "emr_ec2_instance_profile_name" {
  type        = string
  description = "Name of the new instance profile for EMR EC2 instances"
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

variable "s3_bucket_name_for_root_directory" {
  type        = string
  description = "S3 bucket name for storing root directory"
}

variable "aws_region_of_dynamodb_table" {
  type        = string
  description = "AWS region where the DynamoDB table for EMRFS metadata is located"
  default     = "us-east-1"
}

variable "emrfs_metadata_table_name" {
  type        = string
  description = "Table name of EMRFS metadata table in DynamoDB"
  default     = "EmrFSMetadata"
}

variable "s3_bucket_name_for_logs" {
  type        = string
  description = "S3 bucket name/directory for cluster logs."
}

variable "emr_service_iam_policy_name" {
  type        = string
  description = "Name for the IAM policy attached to the EMR Service role"
  default     = "tamr-emr-service-policy"
}

variable "emr_ec2_iam_policy_name" {
  type        = string
  description = "Name for the IAM policy attached to the EMR service role"
  default     = "tamr-emr-ec2-policy"
}
