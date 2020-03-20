output "emr_managed_master_sg_id" {
  value = aws_security_group.emr_managed_master.id
  description = "Security group id for Master Managed Security Group for EMR Master"
}

output "emr_managed_agent_sg_id" {
  value = aws_security_group.emr_managed_agent.id
  description = "Security group id for Agent Managed Security Group for EMR Agent"
}

output "emr_additional_master_sg_id" {
  value = aws_security_group.emr_additional_master.id
  description = "Security group id for Additional Security Group for EMR Master"
}

output "emr_additional_agent_sg_id" {
  value = aws_security_group.emr_additional_agent.id
  description = "Security group id for Additional Security Group for EMR Agent"
}

output "emr_service_access_sg_id" {
  value = aws_security_group.emr_service_access_sg.id
  description = "Security group id for Service Access Security Group for EMR"
}
