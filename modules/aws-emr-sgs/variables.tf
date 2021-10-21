variable "vpc_id" {
  type        = string
  description = "VPC ID of the network"
}

variable "emr_managed_sg_name" {
  type        = string
  description = "Name for the EMR managed security group"
  default     = "TAMR-EMR-Internal"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "emr_service_access_sg_ids" {
  type        = list(string)
  description = "List of EMR service access security group ids"
}
