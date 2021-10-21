locals {
  static_cluster = var.create_static_cluster && length(aws_emr_cluster.emr-cluster) > 0
}

output "tamr_emr_cluster_id" {
  value       = local.static_cluster ? aws_emr_cluster.emr-cluster[0].id : ""
  description = "Identifier for the AWS EMR cluster created"
}

output "tamr_emr_cluster_name" {
  value       = local.static_cluster ? aws_emr_cluster.emr-cluster[0].name : ""
  description = "Name of the AWS EMR cluster created"
}

output "release_label" {
  value       = var.release_label
  description = "The release label for the Amazon EMR release."
}

output "master_instance_on_demand_count" {
  value       = var.master_instance_on_demand_count
  description = "Number of on-demand master instances configured"
}

output "master_instance_spot_count" {
  value       = var.master_instance_spot_count
  description = "Number of spot master instances configured"
}

output "master_instance_total_count" {
  value       = var.master_instance_on_demand_count + var.master_instance_spot_count
  description = "Total number of on-demand and spot instances in master fleet"
}

output "core_instance_on_demand_count" {
  value       = var.core_instance_on_demand_count
  description = "Number of on-demand core instances configured"
}

output "core_instance_spot_count" {
  value       = var.core_instance_spot_count
  description = "Number of spot core instances configured"
}

output "core_instance_total_count" {
  value       = var.core_instance_on_demand_count + var.core_instance_spot_count
  description = "Total number of on-demand and spot instances in core fleet"
}

output "core_ebs_size" {
  value       = var.core_ebs_size
  description = "The core EBS volume size, in gibibytes (GiB)."
}

output "core_ebs_type" {
  value       = var.core_ebs_type
  description = "The core EBS volume size, in gibibytes (GiB)."
}

output "core_ebs_volumes_count" {
  value       = var.core_ebs_volumes_count
  description = "Number of volumes to attach to the core nodes"
}

output "core_instance_type" {
  value       = var.core_instance_type
  description = "The EC2 instance type of the core nodes"
}

output "master_instance_type" {
  value       = var.master_instance_type
  description = "The EC2 instance type of the master nodes"
}

output "master_ebs_volumes_count" {
  value       = var.master_ebs_volumes_count
  description = "Number of volumes to attach to the master nodes"
}

output "master_instance" {
  value       = data.aws_instance.master
  description = "The EC2 instance of the master node"
}

output "master_ebs_size" {
  value       = var.master_ebs_size
  description = "The master EBS volume size, in gibibytes (GiB)."
}

output "master_ebs_type" {
  value       = var.master_ebs_type
  description = "Type of volumes to attach to the master nodes. Valid options are gp2, io1, standard and st1"
}

output "log_uri" {
  value       = local.static_cluster ? aws_emr_cluster.emr-cluster[0].log_uri : "s3n://${var.bucket_name_for_logs}/${var.bucket_path_to_logs}"
  description = "The path to the S3 location where logs for this cluster are stored."
}

output "subnet_id" {
  value       = var.subnet_id
  description = "ID of the subnet where EMR cluster was created"
}
