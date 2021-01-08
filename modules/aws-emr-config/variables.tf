variable "emr_config_file_path" {
  type        = string
  description = "Path to the EMR JSON configuration file. Please include the file name as well."
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

variable "emrfs_metadata_table_name" {
  type        = string
  description = "Table name of EMRFS metadata table in DynamoDB"
  default     = "EmrFSMetadata"
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

variable "cluster_name" {
  type        = string
  description = "Name for the EMR cluster to be created"
  default     = "TAMR-EMR-Cluster"
}

variable "json_configuration_bucket_key" {
  type        = string
  description = "Key (i.e. path) of JSON configuration bucket object in the root directory bucket"
  default     = "config.json"
}

variable "utility_script_bucket_key" {
  type        = string
  description = "Key (i.e. path) to upload the utility script to"
  default     = "util/upload_hbase_config.sh"
}
