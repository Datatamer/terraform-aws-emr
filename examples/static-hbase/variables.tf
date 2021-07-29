variable "bucket_name_for_logs" {
  type        = string
  description = "S3 bucket name for cluster logs."
}

variable "bucket_name_for_root_directory" {
  type        = string
  description = "S3 bucket name for storing root directory"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID of the network"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the EMR cluster will be created. This Subnet is required to be Tagged with what is in abac_tags"
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
  default     = ["0.0.0.0/0"]
  description = "CIDR blocks to attach to security groups for egress"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources created by this example."
  default = {
    Author      = "Tamr"
    Environment = "Example"
  }
}

variable "abac_tags" {
  type        = map(string)
  description = "A map of tags that will be inserted inside IAM Policies conditions for restricting EMR Service Role access"
  default = {
    "tamr.com/role" = "emr"
  }
}
