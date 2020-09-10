variable "bucket_name_for_logs" {
  type        = string
  description = "S3 bucket name for EMR Hbase logs"
  default     = "tamr-emr-hbase-logs"
}

variable "create_new_logs_bucket" {
  type        = bool
  description = "True if provided bucket_name_for_logs needs to be newly created"
  default     = true
}

variable "bucket_name_for_hbase_root_dir" {
  type        = string
  description = "S3 bucket name for EMR Hbase root directory"
  default     = "tamr-emr-hbase-root-dir"
}

variable "create_new_rootdir_bucket" {
  type        = bool
  description = "True if provided bucket_name_for_hbase_root_dir needs to be newly created"
  default     = true
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to be attached to the resources created"
  default     = {}
}
