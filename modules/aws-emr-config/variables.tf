variable "emr_config_file_path" {
  type        = string
  description = "Path to the EMR JSON configuration file. Please include the file name as well."
}

variable "bucket_name_for_root_directory" {
  type        = string
  description = "S3 bucket name for storing root directory"
}

variable "create_static_cluster" {
  type        = bool
  description = "True if the module should create a static cluster. False if the module should create supporting infrastructure but not the cluster itself."
  default     = true
}

variable "hbase_config_path" {
  type        = string
  description = "Path in root directory bucket to upload HBase config to"
  default     = "config/hbase/conf.dist/"
}

variable "hadoop_config_path" {
  type        = string
  description = "Path in root directory bucket to upload Hadoop config to"
  default     = "config/hadoop/conf/"
}

variable "utility_script_bucket_key" {
  type        = string
  description = "Key (i.e. path) to upload the utility script to"
  default     = "util/upload_hbase_config.sh"
}
