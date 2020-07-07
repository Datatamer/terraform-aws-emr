output "s3_bucket_name_for_logs" {
  value       = module.emr-hbase-s3.s3_bucket_name_for_logs
  description = "S3 bucket name for EMR logs"
}

output "s3_bucket_name_for_hbase_rootdir" {
  value       = module.emr-hbase-s3.s3_bucket_name_for_hbase_rootdir
  description = "S3 bucket name for EMR Hbase root directory"
}

output "emr_managed_master_sg_id" {
  value       = module.emr-hbase-sgs.emr_managed_master_sg_id
  description = "Security group id of the EMR Managed Master Security Group"
}

output "emr_managed_core_sg_id" {
  value       = module.emr-hbase-sgs.emr_managed_core_sg_id
  description = "Security group id of the EMR Managed Core Security Group"
}

output "emr_additional_master_sg_id" {
  value       = module.emr-hbase-sgs.emr_additional_master_sg_id
  description = "Security group id of the EMR Additional Master Security Group"
}

output "emr_additional_core_sg_id" {
  value       = module.emr-hbase-sgs.emr_additional_core_sg_id
  description = "Security group id of the EMR Additional Core Security Group"
}

output "emr_service_access_sg_id" {
  value       = module.emr-hbase-sgs.emr_service_access_sg_id
  description = "Security group id of Service Access Security Group"
}

output "emr_service_role_arn" {
  value       = module.emr-hbase-iam.emr_service_role_arn
  description = "ARN of the EMR Hbase service role created"
}

output "emr_ec2_role_arn" {
  value       = module.emr-hbase-iam.emr_ec2_role_arn
  description = "ARN of the EMR Hbase role created for EC2 instances"
}

output "emr_ec2_instance_profile_arn" {
  value       = module.emr-hbase-iam.emr_ec2_instance_profile_arn
  description = "ARN of the EMR Hbase service role created"
}

output "tamr_emr_cluster_id" {
  value       = aws_emr_cluster.emr-hbase.id
  description = "Identifier for the AWS EMR cluster created"
}

output "emrfs_dynamodb_table_id" {
  value       = module.emrfs-dynamodb.emrfs_dynamodb_table_id
  description = "ID for the emrfs dynamodb table"
}

output "emrfs_dynamodb_table_name" {
  value       = module.emrfs-dynamodb.emrfs_dynamodb_table_name
  description = "Name for the emrfs dynamodb table"
}
