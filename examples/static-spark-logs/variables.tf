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

variable "compute_subnet_id" {
  type        = string
  description = "ID of the subnet where the EMR cluster will be created. If `abac_valid_tags` key values are set, this subnet is required to have a valid key value tag as well."
}

variable "vpce_logs_endpoint_dnsname" {
  type        = string
  description = "DNS name of the Cloudwatch VPC Interface Endpoint which will be provided to the script to install and configure the Cloudwatch agent."
}
