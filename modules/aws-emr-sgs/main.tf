//Resource to create security group for internal communication within the cluster
resource "aws_security_group" "emr_managed_internal" {
  vpc_id                 = var.vpc_id
  description            = "EMR Managed Security Group"
  revoke_rules_on_delete = true
  name                   = var.emr_managed_sg_name
  tags                   = var.tags
}
