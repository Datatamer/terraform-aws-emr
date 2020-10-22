variable "create_static_cluster" {
  type        = bool
  description = "True if the module should create a static cluster. False if the module should create supporting infrastructure but not the cluster itself."
  default     = true
}

variable "name_prefix" {
  type        = string
  description = "A prefix to add to the names of all created resources"
}

variable "key_pair_name" {
  type        = string
  description = "Name of the Key Pair that will be attached to the EC2 instances"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID of the network"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the EMR cluster will be created"
}

variable "emr_config_file_path" {
  type        = string
  description = "Path to the EMR JSON configuration file. Please include the file name as well."
}

variable "bucket_name_for_logs" {
  type        = string
  description = "S3 bucket name for cluster logs."
}

variable "bucket_path_to_logs" {
  type        = string
  description = "Path in logs bucket to store cluster logs e.g. mycluster/logs"
  default     = ""
}

variable "bucket_name_for_root_directory" {
  type        = string
  description = "S3 bucket name for storing root directory"
}

variable "tamr_cidrs" {
  type        = list(string)
  description = "List of CIDRs for Tamr"
  default     = []
}

variable "tamr_sgs" {
  type        = list(string)
  description = "Security Groups for the Tamr Instance"
  default     = []
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

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to be attached to the resources created"
  default     = {}
}

variable "aws_region_of_dynamodb_table" {
  type        = string
  description = "AWS region where the DynamoDB table for EMRFS metadata is located"
  default     = "us-east-1"
}

variable "s3_policy_arns" {
  type        = list(string)
  description = "List of policy ARNs to attach to EMR EC2 instance profile."
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

variable "release_label" {
  type        = string
  description = "The release label for the Amazon EMR release."
  default     = "emr-5.29.0"
}

variable "master_instance_type" {
  type        = string
  description = "The EC2 instance type of the master nodes"
  default     = "m4.xlarge"
}

variable "core_instance_type" {
  type        = string
  description = "The EC2 instance type of the core nodes"
  default     = "m4.xlarge"
}

variable "master_group_instance_count" {
  type        = number
  default     = 1
  description = "Number of instances for the master instance group. Must be 1 or 3."
}

variable "core_group_instance_count" {
  type        = number
  default     = 1
  description = "Number of Amazon EC2 instances used to execute the job flow"
}

variable "applications" {
  type        = list(string)
  description = "List of applications to run on EMR"
}

variable "core_ebs_volumes_count" {
  type        = number
  description = "Number of volumes to attach to the core nodes"
  default     = 1
}

variable "core_ebs_type" {
  type        = string
  description = "Type of volumes to attach to the core nodes. Valid options are gp2, io1, standard and st1"
  default     = "gp2"
}

variable "core_ebs_size" {
  type        = string
  description = "The volume size, in gibibytes (GiB)."
  default     = "500"
}

variable "master_ebs_volumes_count" {
  type        = number
  description = "Number of volumes to attach to the master nodes"
  default     = 1
}

variable "master_ebs_type" {
  type        = string
  description = "Type of volumes to attach to the master nodes. Valid options are gp2, io1, standard and st1"
  default     = "gp2"
}

variable "master_ebs_size" {
  type        = string
  description = "The volume size, in gibibytes (GiB)."
  default     = "100"
}

variable "enable_http_port" {
  type        = bool
  description = "EMR services like Ganglia run on the http port"
  default     = false
}
