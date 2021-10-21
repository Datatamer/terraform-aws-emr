output "emr_managed_master_sg_id" {
  value       = module.emr-sgs.emr_managed_master_sg_id
  description = "Security group id of the EMR Managed Master Security Group"
}

output "emr_managed_core_sg_id" {
  value       = module.emr-sgs.emr_managed_core_sg_id
  description = "Security group id of the EMR Managed Core Security Group"
}

output "emr_additional_master_sg_id" {
  value       = module.emr-sgs.emr_additional_master_sg_id
  description = "Security group id of the EMR Additional Master Security Group"
}

output "emr_additional_core_sg_id" {
  value       = module.emr-sgs.emr_additional_core_sg_id
  description = "Security group id of the EMR Additional Core Security Group"
}

output "emr_service_access_sg_id" {
  value       = module.emr-sgs.emr_service_access_sg_id
  description = "Security group id of Service Access Security Group"
}

output "emr_service_role_arn" {
  value       = module.emr-iam.emr_service_role_arn
  description = "ARN of the EMR service role created"
}

output "emr_service_role_name" {
  value       = module.emr-iam.emr_service_role_name
  description = "Name of the EMR service role created"
}

output "emr_ec2_role_arn" {
  value       = module.emr-iam.emr_ec2_role_arn
  description = "ARN of the EMR EC2 role created for EC2 instances"
}

output "emr_ec2_instance_profile_arn" {
  value       = module.emr-iam.emr_ec2_instance_profile_arn
  description = "ARN of the EMR EC2 instance profile created"
}

output "emr_ec2_instance_profile_name" {
  value       = module.emr-iam.emr_ec2_instance_profile_name
  description = "Name of the EMR EC2 instance profile created"
}

output "tamr_emr_cluster_id" {
  value       = module.emr-cluster.tamr_emr_cluster_id
  description = "Identifier for the AWS EMR cluster created. Empty string if set up infrastructure for ephemeral cluster."
}

output "tamr_emr_cluster_name" {
  value       = module.emr-cluster.tamr_emr_cluster_name
  description = "Name of the AWS EMR cluster created"
}

output "master_fleet_instance_count" {
  value       = module.emr-cluster.master_instance_total_count
  description = "Number of on-demand and spot master instances configured"
}

output "master_instance_type" {
  value       = module.emr-cluster.master_instance_type
  description = "The EC2 instance type of the master nodes"
}

output "master_instance_id" {
  value       = module.emr-cluster.master_instance_id
  description = "The EC2 instance id of the master nodes"
}

output "master_ebs_volumes_count" {
  value       = module.emr-cluster.master_ebs_volumes_count
  description = "Number of volumes to attach to the master nodes"
}

output "master_ebs_size" {
  value       = module.emr-cluster.master_ebs_size
  description = "The master EBS volume size, in gibibytes (GiB)."
}

output "master_ebs_type" {
  value       = module.emr-cluster.master_ebs_type
  description = "Type of volumes to attach to the master nodes. Valid options are gp2, io1, standard and st1"
}

output "core_fleet_instance_count" {
  value       = module.emr-cluster.core_instance_total_count
  description = "Number of on-demand and spot core instances configured"
}

output "core_instance_type" {
  value       = module.emr-cluster.core_instance_type
  description = "The EC2 instance type of the core nodes"
}

output "core_ebs_size" {
  value       = module.emr-cluster.core_ebs_size
  description = "The core EBS volume size, in gibibytes (GiB)."
}

output "core_ebs_type" {
  value       = module.emr-cluster.core_ebs_type
  description = "The core EBS volume size, in gibibytes (GiB)."
}

output "core_ebs_volumes_count" {
  value       = module.emr-cluster.core_ebs_volumes_count
  description = "Number of volumes to attach to the core nodes"
}

output "release_label" {
  value       = module.emr-cluster.release_label
  description = "The release label for the Amazon EMR release."
}

output "log_uri" {
  value       = module.emr-cluster.log_uri
  description = "The path to the S3 location where logs for this cluster are stored."
}

output "subnet_id" {
  value       = module.emr-cluster.subnet_id
  description = "ID of the subnet where EMR cluster was created"
}

output "json_config_s3_key" {
  value       = module.emr-cluster-config.json_config_s3_key
  description = "The name of the json configuration object in the bucket."
}

output "upload_config_script_s3_key" {
  value       = module.emr-cluster-config.upload_config_script_s3_key
  description = "The name of the upload config script object in the bucket."
}

output "hbase_config_path" {
  value       = module.emr-cluster-config.hbase_config_path
  description = "Path in the root directory bucket that HBase config was uploaded to."
}
