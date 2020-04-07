output "emr_managed_master_sg_id" {
  value = aws_security_group.emr_managed_master.id
  description = "Security group id of the EMR Managed Master Security Group"
}

output "emr_managed_core_sg_id" {
  value = aws_security_group.emr_managed_core.id
  description = "Security group id of the EMR Managed Core Security Group"
}

output "emr_additional_master_sg_id" {
  value = aws_security_group.emr_additional_master.id
  description = "Security group id of the EMR Additional Master Security Group"
}

output "emr_additional_core_sg_id" {
  value = aws_security_group.emr_additional_core.id
  description = "Security group id of the EMR Additional Core Security Group"
}

output "emr_service_access_sg_id" {
  value = aws_security_group.emr_service_access_sg.id
  description = "Security group id of Service Access Security Group"
}
