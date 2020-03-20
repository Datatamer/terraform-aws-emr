variable "name" {
    type = string
    description = "Name of EMR HBase cluster"
}

variable "subnet_id" {
    type = string
    description = "VPC subnet id where you want the job flow to launch"
}

variable "emr_managed_master_security_group" {
    type = string
    description = "Identifier of the Amazon EC2 EMR-Managed security group for the master node"
}

variable "additional_master_security_groups" {
    type = string
    description = "String containing a comma separated list of additional Amazon EC2 security group IDs for the master node"
}

variable "emr_managed_slave_security_group" {
    type = string
    description = "Identifier of the Amazon EC2 EMR-Managed security group for the slave nodes"
}

variable "additional_slave_security_groups" {
    type = string
    description = "String containing a comma separated list of additional Amazon EC2 security group IDs for the slave nodes as a comma separated string"
}

variable "service_access_security_group" {
    type = string
    description = "Identifier of the Amazon EC2 service-access security group - required when the cluster runs on a private subnet"
}

variable "instance_profile" {
    type = string
    description = "ARN of the Instance Profile for EC2 instances of the cluster assume this role"
}

variable "service_role" {
    type = string
    description = "ARN of the service role for AWS EMR cluster"
}

variable "key_name" {
    type = string
    description = "Amazon EC2 key pair that can be used to ssh to the master node as the user called hadoop"
}

variable "master_instance_group_name" {
    type = string
    description = "Friendly name given to the instance group."
    default = "MasterInstanceGroup"
}

variable "core_instance_group_name" {
    type = string
    description = "Friendly name given to the instance group."
    default = "CoreInstanceGroup"
}

variable "release_label" {
    type = string
    description = "The release label for the Amazon EMR release."
    default = "emr-5.11.2"
}

variable "master_instance_type" {
    type = string
    description = "The EC2 instance type of the master nodes"
    default = "m4.xlarge"
}

variable "core_instance_type" {
    type = string
    description = "The EC2 instance type of the core nodes"
    default = "m4.xlarge"
}

variable "master_group_instance_count" {
    type = number
    default = 1
    description = "Number of instances for the master instance group. Must be 1 or 3."
}

variable "core_group_instance_count" {
    default = 1
    description = "Number of Amazon EC2 instances used to execute the job flow"
}

variable "tags" {
    type = map(string)
    description = "Map of tags"
    default = {}
}

variable "emr_hbase_s3_bucket_logs" {
    type = string
    description = "S3 bucket for logs for EMR Hbase"
}

variable "emr_hbase_s3_bucket_root_dir" {
    type = string
    description = "S3 bucket for root directory for EMR Hbase"
}

variable "path_to_config_file" {
    type = string
    description = "Path to the EMR Hbase JSON config file. Please include filename too."
}

variable "emrfs_metadata_table_name" {
    type = string
    description = "Table name of the dynamodb table for EMRFS metadata"
    default = "EmrFSMetadata"
}

variable "emrfs_metadata_read_capacity" {
    type = number
    description = "Read capacity units of the dynamodb table used for EMRFS metadata"
    default = 600
}

variable "emrfs_metadata_write_capacity" {
    type = number
    description = "Write capacity units of the dynamodb table used for EMRFS metadata"
    default = 300
}
