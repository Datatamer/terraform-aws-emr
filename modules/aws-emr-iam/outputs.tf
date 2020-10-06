output "emr_service_role_arn" {
  value       = aws_iam_role.emr_hbase_service_role.arn
  description = "ARN of the EMR Hbase service role created"
}

output "emr_service_role_name" {
  value       = aws_iam_role.emr_hbase_service_role.name
  description = "Name of the EMR HBase service role created"
}

output "emr_ec2_role_arn" {
  value       = aws_iam_role.emr_ec2_instance_profile.arn
  description = "ARN of the EMR Hbase role created for EC2 instances"
}

output "emr_ec2_instance_profile_arn" {
  value       = aws_iam_instance_profile.emr_ec2_instance_profile.arn
  description = "ARN of the EMR Hbase service role created"
}
