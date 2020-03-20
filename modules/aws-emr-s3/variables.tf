variable "bucket_name_for_logs" {
  type = string
  description = "S3 bucket name for EMR Hbase logs"
}

variable "bucket_name_for_hbase_root_dir" {
  type = string
  description = "S3 bucket name for EMR Hbase root directory"
}
variable "additional_tags" {
  type = map(string)
  description = "Additional tags to be attached to the resources created"
  default = {}
}
