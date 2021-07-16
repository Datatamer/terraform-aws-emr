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
