output "emr_service_role_arn" {
  value       = aws_iam_role.emr_service_role.arn
  description = "ARN of the EMR service role created"
}

output "emr_service_role_name" {
  value       = aws_iam_role.emr_service_role.name
  description = "Name of the EMR service role created"
}

output "emr_ec2_role_arn" {
  value       = aws_iam_role.emr_ec2_instance_profile.arn
  description = "ARN of the EMR role created for EC2 instances"
}

output "emr_ec2_instance_profile_arn" {
  value       = aws_iam_instance_profile.emr_ec2_instance_profile.arn
  description = "ARN of the EMR EC2 instance profile created"
}

output "emr_ec2_instance_profile_name" {
  value       = aws_iam_instance_profile.emr_ec2_instance_profile.name
  description = "Name of the EMR EC2 instance profile created"
}
