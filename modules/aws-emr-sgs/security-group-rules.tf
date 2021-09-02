//Combined TCP, UDP, ICMP SG rule for EMR Managed Internal SG
resource "aws_security_group_rule" "all_ports_for_internal_sg" {
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.emr_managed_internal.id
  type                     = "ingress"
  source_security_group_id = aws_security_group.emr_managed_internal.id
  description              = "Combined TCP/UDP/ICMP"
}

//Egress SG rule for EMR Managed Internal SG
resource "aws_security_group_rule" "egress_for_internal_sg" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.emr_managed_internal.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  description       = "Egress rule for EMR Managed Internal SG"
}

// Ingress on port 9443 from the master security group is required since EMR 5.30.0
// https://github.com/hashicorp/terraform-provider-aws/issues/14338#issuecomment-667477317
resource "aws_security_group_rule" "service_access_ingress_rule" {
  count                    = length(var.emr_service_access_sg_ids)
  description              = "Ingress on port 9443 from the master sg"
  security_group_id        = element(var.emr_service_access_sg_ids, count.index)
  type                     = "ingress"
  from_port                = 9443
  to_port                  = 9443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.emr_managed_internal.id
}
