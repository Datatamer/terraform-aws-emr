variable "vpc_id" {
  type        = string
  description = "VPC ID of the network"
}

variable "emr_managed_master_sg_name" {
  type        = string
  description = "Name for the EMR managed master security group"
  default     = "TAMR-EMR-Master"
}

variable "emr_managed_core_sg_name" {
  type        = string
  description = "Name for the EMR managed core security group"
  default     = "TAMR-EMR-Core"
}

variable "emr_additional_master_sg_name" {
  type        = string
  description = "Name for the EMR additional master security group"
  default     = "TAMR-EMR-Master-Additional"
}

variable "emr_additional_core_sg_name" {
  type        = string
  description = "Name for the EMR additional core security group"
  default     = "TAMR-EMR-Core-Additional"
}

variable "emr_service_access_sg_name" {
  type        = string
  description = "Name for the EMR service access security group"
  default     = "TAMR-EMR-Service-Access"
}

variable "tamr_cidrs" {
  type        = list(string)
  description = "List of CIDRs for Tamr"
  default     = []
}

variable "tamr_sgs" {
  type        = list(string)
  description = "Security Group for the Tamr Instance"
  default     = []
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to be attached to the resources created"
  default     = {}
}
