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

output "tamr_emr_cluster_id" {
  value       = module.emr-cluster.tamr_emr_cluster_id
  description = "Identifier for the AWS EMR cluster created. Empty string if set up infrastructure for ephemeral cluster."
}

output "tamr_emr_cluster_name" {
  value       = var.create_static_cluster ? aws_emr_cluster.emr-cluster[0].name : ""
  description = "Name of the AWS EMR cluster created"
}

output "emrfs_dynamodb_table_id" {
  value       = module.emrfs-dynamodb.emrfs_dynamodb_table_id
  description = "ID for the emrfs dynamodb table"
}

output "emrfs_dynamodb_table_name" {
  value       = module.emrfs-dynamodb.emrfs_dynamodb_table_name
  description = "Name for the emrfs dynamodb table"
}

output "json_config_s3_key" {
  value       = module.emr-cluster-config.json_config_s3_key
  description = "The name of the json configuration object in the bucket."
}

output "upload_config_script_s3_key" {
  value       = module.emr-cluster-config.upload_config_script_s3_key
  description = "The name of the upload config script object in the bucket."
}

output "security_configuration_name" {
  value       = module.emr-cluster-config.security_configuration_name
  description = "Name of the EMR cluster's security configuration"
}
