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
  description = "ID of the subnet where the EMR cluster will be created"
}

variable "master_name_prefix" {
  description = "A string to prepend to names of resources created by this example"
}

variable "core_name_prefix" {
  description = "A string to prepend to names of resources created by this example"
}

variable "ingress_cidr_blocks" {
  description = "CIDR blocks to attach to security groups for ingress"
  type = list(string)
}

variable "egress_cidr_blocks" {
  description = "CIDR blocks to attach to security groups for egress"
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources created by this example."
  default = {
    Author      = "Tamr"
    Environment = "Example"
  }
}
