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

output "core_group_instance_count" {
  value       = var.core_group_instance_count
  description = "Number of cores configured to execute the job flow"
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

output "master_ebs_size" {
  value       = var.master_ebs_size
  description = "The master EBS volume size, in gibibytes (GiB)."
}

output "master_ebs_type" {
  value       = var.master_ebs_type
  description = "Type of volumes to attach to the master nodes. Valid options are gp2, io1, standard and st1"
}

output "log_uri" {
  value       = local.static_cluster ? aws_emr_cluster.emr-cluster[0].log_uri : "s3n://${var.bucket_name_for_logs}/${var.bucket_path_to_logs}/"
  description = "The path to the S3 location where logs for this cluster are stored."
}

output "subnet_id" {
  value       = var.subnet_id
  description = "ID of the subnet where EMR cluster was created"
}
