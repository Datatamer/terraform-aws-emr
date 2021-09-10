variable "bucket_name_for_logs" {
  type        = string
  description = "S3 bucket name for cluster logs."
}

variable "bucket_name_for_root_directory" {
  type        = string
  description = "S3 bucket name for storing root directory"
}

variable "name_prefix" {
  type        = string
  description = "A string to prepend to names of the resources in the cluster"
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks to attach to security groups for ingress"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks to attach to security groups for egress"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources created by this example."
  default     = {}
}

variable "abac_tags" {
  type        = map(string)
  description = "A map of tags to add to ABAC resources"
  default     = {}
}

variable "abac_valid_tags" {
  type        = map(list(string))
  description = "Valid tags for maintaining resources when using ABAC IAM Policies with Tag Conditions. Make sure `tags` contain a key value specified here."
  default     = {}
}

variable "vpc_cidr" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}
