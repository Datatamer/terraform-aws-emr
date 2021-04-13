variable "cluster_name" {
  type        = string
  description = "Name for the EMR cluster to be created"
  default     = "TAMR-EMR-Cluster"
}

variable "create_static_cluster" {
  type        = bool
  description = "True if the module should create a static cluster. False if the module should create supporting infrastructure but not the cluster itself."
  default     = true
}

variable "json_configuration_bucket_key" {
  type        = string
  description = "Key (i.e. path) of JSON configuration bucket object in the root directory bucket"
  default     = "config.json"
}

variable "bucket_name_for_root_directory" {
  type        = string
  description = "S3 bucket name for storing root directory"
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

variable "release_label" {
  type        = string
  description = "The release label for the Amazon EMR release."
  default     = "emr-5.29.0"
}

variable "applications" {
  type        = list(string)
  description = "List of applications to run on EMR"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the EMR cluster will be created"
}

variable "key_pair_name" {
  type        = string
  description = "Name of the Key Pair that will be attached to the EC2 instances"
}

variable "master_instance_group_name" {
  type        = string
  description = "Name for the master instance group"
  default     = "MasterInstanceGroup"
}

variable "master_instance_type" {
  type        = string
  description = "The EC2 instance type of the master nodes"
  default     = "m4.xlarge"
}

variable "master_group_instance_count" {
  type        = number
  default     = 1
  description = "Number of instances for the master instance group. Must be 1 or 3."
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

variable "core_instance_group_name" {
  type        = string
  description = "Name for the core instance group"
  default     = "CoreInstanceGroup"
}

variable "core_instance_type" {
  type        = string
  description = "The EC2 instance type of the core nodes"
  default     = "m4.xlarge"
}

variable "core_group_instance_count" {
  type        = number
  default     = 1
  description = "Number of Amazon EC2 instances used to execute the job flow"
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

variable "emr_service_role_arn" {
  type        = string
  description = "ARN of the IAM service role for the EMR cluster"
}

variable "emr_managed_master_sg_id" {
  type        = string
  description = "Security group id of the EMR Managed Master Security Group"
}

variable "emr_additional_master_sg_id" {
  type        = string
  description = "Security group id of the EMR Additional Master Security Group"
}

variable "emr_managed_core_sg_id" {
  type        = string
  description = "Security group id of the EMR Managed Core Security Group"
}

variable "emr_additional_core_sg_id" {
  type        = string
  description = "Security group id of the EMR Additional Core Security Group"
}

variable "emr_service_access_sg_id" {
  type        = string
  description = "Security group id of Service Access Security Group"
}

variable "emr_ec2_instance_profile_arn" {
  type        = string
  description = "ARN of the EMR EC2 instance profile"
}

variable "bootstrap_actions" {
  type = list(object({
    name = string
    path = string
    args = list(string)
  }))
  description = "Ordered list of bootstrap actions that will be run before Hadoop is started on the cluster nodes."
  default     = []
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to be attached to the resources created"
  default     = {}
}

variable "utility_script_bucket_key" {
  type        = string
  description = "Key (i.e. path) to upload the utility script to"
  default     = "util/upload_hbase_config.sh"
}

variable "custom_ami_id" {
  type        = string
  description = "The ID of a custom Amazon EBS-backed Linux AMI"
  default     = null
}

variable "core_bid_price" {
  type        = string
  description = <<EOF
  Bid price for each EC2 instance in the core instance group, expressed in USD. By setting this attribute,
  the instance group is being declared as a Spot Instance, and will implicitly create a Spot request.
  Leave this blank to use On-Demand Instances
  EOF
  default     = ""
}

variable "master_bid_price" {
  type        = string
  description = <<EOF
  Bid price for each EC2 instance in the master instance group, expressed in USD. By setting this attribute,
  the instance group is being declared as a Spot Instance, and will implicitly create a Spot request.
  Leave this blank to use On-Demand Instances
  EOF
  default     = ""
}
