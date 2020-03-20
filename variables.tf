variable "bucket_name_for_logs" {
  type = string
  description = "S3 bucket name for EMR Hbase logs"
}

variable "bucket_name_for_hbase_root_dir" {
  type = string
  description = "S3 bucket name for EMR Hbase root directory"
}

variable "aws_account_id" {
  type = string
  description = "Account ID of the AWS account"
}

variable "vpc_id" {
  type = string
  description = "VPC id of the network"
}

variable "key_pair_name" {
  type = string
  description = "Name of the Key Pair that will be attached to the EC2 instances"
}

variable "subnet_id" {
  type = string
  description = "ID of the subnet where the emr cluster will be created"
}
