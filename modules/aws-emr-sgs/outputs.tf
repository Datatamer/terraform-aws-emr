output "emr_managed_sg_id" {
  value       = aws_security_group.emr_managed_internal.id
  description = "Security group id of the EMR Managed Security Group"
}
