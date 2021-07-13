variable "vpc_id" {
  type        = string
  description = "VPC ID of the network"
}

variable "emr_managed_sg_name" {
  type        = string
  description = "Name for the EMR managed security group"
  default     = "TAMR-EMR-Internal"
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to be attached to the resources created"
  default     = {}
}
