variable "create_static_cluster" {
  type        = bool
  description = "True if the module should create a static cluster. False if the module should create supporting infrastructure but not the cluster itself."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to be attached to the DynamoDB table"
  default     = {}
}

variable "emrfs_metadata_table_name" {
  type        = string
  description = "Table name of EMRFS metadata table in DynamoDB"
  default     = "EmrFSMetadata"
}

variable "emrfs_metadata_read_capacity" {
  type        = number
  description = "Read capacity units of the DynamoDB table used for EMRFS metadata"
  default     = 600
}

variable "emrfs_metadata_write_capacity" {
  type        = number
  description = "Write capacity units of the DynamoDB table used for EMRFS metadata"
  default     = 300
}
