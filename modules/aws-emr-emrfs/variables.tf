variable "tags" {
  type        = map(string)
  description = "Map of tags"
  default     = {}
}

variable "emrfs_metadata_table_name" {
  type        = string
  description = "Table name of the dynamodb table for EMRFS metadata"
  default     = "EmrFSMetadata"
}

variable "emrfs_metadata_read_capacity" {
  type        = number
  description = "Read capacity units of the dynamodb table used for EMRFS metadata"
  default     = 600
}

variable "emrfs_metadata_write_capacity" {
  type        = number
  description = "Write capacity units of the dynamodb table used for EMRFS metadata"
  default     = 300
}

