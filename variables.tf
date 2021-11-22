variable "create_static_cluster" {
  type        = bool
  description = "True if the module should create a static cluster. False if the module should create supporting infrastructure but not the cluster itself."
  default     = true
}

variable "vpc_id" {
  type        = string
  description = "VPC ID of the network"

}
variable "key_pair_name" {
  type        = string
  description = "Name of the Key Pair that will be attached to the EC2 instances"
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

variable "cluster_name" {
  type        = string
  description = "Name for the EMR cluster to be created"
  default     = "TAMR-EMR-Cluster"
}

variable "additional_tags" {
  type        = map(string)
  description = "[DEPRECATED: Use `tags` instead] Additional tags to be attached to the resources created."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources. Replaces `additional_tags`."
  default     = {}
}

variable "abac_valid_tags" {
  type        = map(list(string))
  description = "Valid tags for maintaining resources when using ABAC IAM Policies with Tag Conditions. Make sure `tags` contain a key value specified here."
  default     = {}
}

variable "emr_service_role_name" {
  type        = string
  description = "Name of the new IAM service role for the EMR cluster"
  default     = "tamr_emr_service_role"
}

variable "emr_ec2_role_name" {
  type        = string
  description = "Name of the new IAM role for EMR EC2 instances"
  default     = "tamr_emr_ec2_role"
}

variable "emr_ec2_instance_profile_name" {
  type        = string
  description = "Name of the new instance profile for EMR EC2 instances"
  default     = "tamr_emr_ec2_instance_profile"
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

variable "master_instance_fleet_name" {
  type        = string
  description = "Name for the master instance fleet"
  default     = "MasterInstanceFleet"
}

variable "master_instance_type" {
  type        = string
  description = "The EC2 instance type of the master nodes"
  default     = "m4.xlarge"
}

variable "master_instance_on_demand_count" {
  type        = number
  default     = 1
  description = "Number of on-demand instances for the master instance fleet"
}

variable "master_instance_spot_count" {
  type        = number
  default     = 0
  description = "Number of spot instances for the master instance fleet"
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

variable "master_bid_price_as_percentage_of_on_demand_price" {
  type        = number
  default     = 100
  description = "Bid price as percentage of on-demand price for master instances"
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

variable "master_block_duration_minutes" {
  type        = number
  description = "Duration for master spot instances, in minutes"
  default     = 0
}

variable "master_timeout_action" {
  type        = string
  description = "Timeout action for master instances"
  default     = "SWITCH_TO_ON_DEMAND"
}

variable "master_timeout_duration_minutes" {
  type        = number
  description = "Spot provisioning timeout for master instances, in minutes"
  default     = 10
}

variable "core_instance_fleet_name" {
  type        = string
  description = "Name for the core instance fleet"
  default     = "CoreInstanceFleet"
}

variable "core_instance_type" {
  type        = string
  description = "The EC2 instance type of the core nodes"
  default     = "m4.xlarge"
}

variable "core_instance_on_demand_count" {
  type        = number
  default     = 1
  description = "Number of on-demand instances for the spot instance fleet"
}

variable "core_instance_spot_count" {
  type        = number
  default     = 0
  description = "Number of spot instances for the spot instance fleet"
}

variable "core_ebs_volumes_count" {
  type        = number
  description = "Number of volumes to attach to the core nodes"
  default     = 1
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

variable "core_bid_price_as_percentage_of_on_demand_price" {
  type        = number
  default     = 100
  description = "Bid price as percentage of on-demand price for core instances"
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

variable "core_block_duration_minutes" {
  type        = number
  description = "Duration for core spot instances, in minutes"
  default     = 0
}

variable "core_timeout_action" {
  type        = string
  description = "Timeout action for core instances"
  default     = "SWITCH_TO_ON_DEMAND"
}

variable "core_timeout_duration_minutes" {
  type        = number
  description = "Spot provisioning timeout for core instances, in minutes"
  default     = 10
}

variable "emr_managed_sg_name" {
  type        = string
  description = "Name for the EMR managed security group"
  default     = "TAMR-EMR-Internal"
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

variable "emr_service_access_sg_name" {
  type        = string
  description = "Name for the EMR Service Access security group"
  default     = "TAMR-EMR-Service-Access"
}

variable "emr_managed_master_sg_ids" {
  type        = list(string)
  description = "List of EMR managed master security group ids"
}

variable "emr_managed_core_sg_ids" {
  type        = list(string)
  description = "List of EMR managed core security group ids"
}

variable "emr_service_access_sg_ids" {
  type        = list(string)
  description = "List of EMR service access security group ids"
}

variable "emr_service_iam_policy_name" {
  type        = string
  description = "Name for the IAM policy attached to the EMR Service role"
  default     = "tamr-emr-service-policy"
}

variable "emr_ec2_iam_policy_name" {
  type        = string
  description = "Name for the IAM policy attached to the EMR service role"
  default     = "tamr-emr-ec2-policy"
}

variable "applications" {
  type        = list(string)
  description = "List of applications to run on EMR"
}

variable "enable_http_port" {
  type        = bool
  description = "EMR services like Ganglia run on the http port"
  default     = false
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

variable "bootstrap_actions" {
  type = list(object({
    name = string
    path = string
    args = list(string)
  }))
  description = "Ordered list of bootstrap actions that will be run before Hadoop is started on the cluster nodes."
  default     = []
}

variable "custom_ami_id" {
  type        = string
  description = "The ID of a custom Amazon EBS-backed Linux AMI"
  default     = null
}

variable "arn_partition" {
  type        = string
  description = <<EOF
  The partition in which the resource is located. A partition is a group of AWS Regions.
  Each AWS account is scoped to one partition.
  The following are the supported partitions:
    aws -AWS Regions
    aws-cn - China Regions
    aws-us-gov - AWS GovCloud (US) Regions
  EOF
  default     = "aws"
}

variable "permissions_boundary" {
  type        = string
  description = "ARN of the policy that will be used to set the permissions boundary for all IAM Roles created by this module"
  default     = null
}

variable "require_abac_for_subnet" {
  type        = bool
  description = "If abac_valid_tags is specified, choose whether or not to require ABAC also for actions related to the subnet"
  default     = true
}
