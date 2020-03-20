variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "tamr_cidrs" {
  type        = list(string)
  description = "List of CIDRs for Tamr"
  default = []
}

variable "tamr_sgs" {
  type = list(string)
  description = "Security Group for the Tamr Instance"
  default = []
}

variable "additional_tags" {
  type = map(string)
  description = "Additional tags to be attached to the resources created"
  default = {}
}
