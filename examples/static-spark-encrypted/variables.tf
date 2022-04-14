variable "vpc_id" {
  type        = string
  description = "VPC ID of the network"
}

variable "bucket_name_for_root_directory" {
  type        = string
  description = "S3 bucket name for storing root directory."
}

variable "bucket_name_for_logs" {
  type        = string
  description = "S3 bucket name for cluster logs."
}

variable "name_prefix" {
  type        = string
  description = "A string to prepend to names of the resources in the cluster"
}

variable "ingress_cidr_blocks" {
  description = "CIDR blocks to attach to security groups for ingress"
  type        = list(string)
}

variable "egress_cidr_blocks" {
  description = "CIDR blocks to attach to security groups for egress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources created by this example."
  default = {
    Author      = "Tamr"
    Environment = "Example"
  }
}

variable "abac_valid_tags" {
  type        = map(list(string))
  description = "Valid tags for maintaining resources when using ABAC IAM Policies with Tag Conditions. Make sure `tags` contain a key value specified here."
  default     = {}
}

variable "application_subnet_id" {
  type        = string
  description = "ID of the subnet where the Tamr VM and the Cloudwatch VPC Endpoint will be created. If `abac_valid_tags` key values are set, this subnet is required to have a valid key value tag as well."
}

variable "compute_subnet_id" {
  type        = string
  description = "ID of the subnet where the EMR cluster will be created. If `abac_valid_tags` key values are set, this subnet is required to have a valid key value tag as well."
}

variable "vpce_logs_endpoint_dnsname" {
  type        = string
  description = "DNS name of the Cloudwatch VPC Interface Endpoint which will be provided to the script to install and configure the Cloudwatch agent."
}

variable "compute_subnet_cidr_block" {
  type        = string
  description = "The EMR Cluster subnet CIDR range"
}
variable "kms_key_arn" {
  type        = string
  description = "Customer Managed key ARN used to encrypt the EBS drives."
  default     = ""
}

variable "enable_in_transit_encryption" {
  type        = bool
  description = "Specify true to enable in-transit encryption and false to disable it."
  default     = true
}

variable "enable_at_rest_encryption" {
  type        = bool
  description = "Specify true to enable at-rest encryption and false to disable it."
  default     = true
}

variable "enable_ebs_encryption" {
  type        = bool
  description = "Specify true to enable EBS encryption. EBS encryption encrypts the EBS root device volume and attached storage volumes."
  default     = true
}

variable "arn_partition" {
  type        = string
  description = <<EOF
  The partition in which the resource is located. A partition is a group of AWS Regions.
  Each AWS account is scoped to one partition.
  The following are the supported partitions:
    aws -AWS Regions
    aws-cn - China Regions
    aws-us-gov - AWS GovCloud (US) Regions
  EOF
  default     = "aws"
}

variable "s3_pem_file_location" {
  type        = string
  description = "Specify the S3 path where the PEM zip file is located."
  default     = "s3://aws-logs-327120324092-us-east-2/my-certs.zip"
}
