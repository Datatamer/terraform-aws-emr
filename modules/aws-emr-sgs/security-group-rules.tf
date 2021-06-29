locals {
  applications        = [for app in var.applications : lower(app)]
  tamr_sgs_provided   = length(var.tamr_sgs) > 0
  tamr_cidrs_provided = length(var.tamr_cidrs) > 0
  running_hbase       = contains(local.applications, "hbase")
  running_spark       = contains(local.applications, "spark")
}

//EMR Cluster Manager SG rule for TAMR CIDRs for EMR Managed Master SG
resource "aws_security_group_rule" "ecm_port_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 8443
  to_port           = 8443
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_managed_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "EMR Cluster Manager for Tamr CIDRs"
}

//EMR Cluster Manager SG rule for TAMR SGs for EMR Managed Master SG
resource "aws_security_group_rule" "ecm_port_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 8443
  to_port                  = 8443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_managed_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "EMR Cluster Manager for Tamr SGs"
}

//Combined TCP, UDP, ICMP SG rule sourcing EMR Managed Master SG in EMR Managed Master SG
resource "aws_security_group_rule" "all_ports_for_master_sg_in_master_sg" {
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.emr_managed_master.id
  type                     = "ingress"
  source_security_group_id = aws_security_group.emr_managed_master.id
  description              = "Combined TCP/UDP/ICMP"
}

//Combined TCP, UDP, ICMP SG rule sourcing EMR Managed Core SG in EMR Managed Master SG
resource "aws_security_group_rule" "all_ports_for_core_sg_in_master_sg" {
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.emr_managed_master.id
  type                     = "ingress"
  source_security_group_id = aws_security_group.emr_managed_core.id
  description              = "Combined TCP/UDP/ICMP"
}

//Egress SG rule for EMR Managed Master SG
resource "aws_security_group_rule" "egress_for_master_sg" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.emr_managed_master.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  description       = "Egress rule for EMR Managed Master SG"
}

//Combined TCP, UDP, ICMP SG rule sourcing EMR Managed Master SG in EMR Managed Core SG
resource "aws_security_group_rule" "all_ports_for_master_sg_in_core_sg" {
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.emr_managed_core.id
  type                     = "ingress"
  source_security_group_id = aws_security_group.emr_managed_master.id
  description              = "Combined TCP/UDP/ICMP"
}

//Combined TCP, UDP, ICMP SG rule sourcing EMR Managed core SG in EMR Managed Core SG
resource "aws_security_group_rule" "all_ports_for_core_sg_in_core_sg" {
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.emr_managed_core.id
  type                     = "ingress"
  source_security_group_id = aws_security_group.emr_managed_core.id
  description              = "Combined TCP/UDP/ICMP"
}

//Egress SG rule for EMR Managed Core SG
resource "aws_security_group_rule" "egress_for_core_sg" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.emr_managed_core.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  description       = "Egress rule for EMR Managed Core SG"
}

//YARN Resource Manager rule - Additional SG for EMR Master with TAMR CIDRS
resource "aws_security_group_rule" "yarn_rm_port_add_master_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 8088
  to_port           = 8088
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Yarn resource manager - EMR Dashboard"
}

//YARN Resource Manager rule - Additional SG for EMR Master with TAMR SGs
resource "aws_security_group_rule" "yarn_rm_port_add_master_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 8088
  to_port                  = 8088
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Yarn resource manager - EMR Dashboard"
}

//YARN Resource Manager rule - Additional SG for EMR Master Proxy with TAMR CIDRS
resource "aws_security_group_rule" "yarn_rm_port_add_master_sg_proxy_tamr_cidrs" {
  count             = local.tamr_cidrs_provided && local.running_spark ? 1 : 0
  from_port         = 20888
  to_port           = 20888
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Yarn resource manager - EMR Dashboard - Proxy"
}

//YARN Resource Manager rule - Additional SG for EMR Master Proxy with TAMR SGs
resource "aws_security_group_rule" "yarn_rm_port_add_master_sg_proxy_tamr_sgs" {
  count                    = local.tamr_sgs_provided && local.running_spark ? length(var.tamr_sgs) : 0
  from_port                = 20888
  to_port                  = 20888
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Yarn resource manager - EMR Dashboard - Proxy"
}

//Hadoop HDFS NameNode rule - Additional SG for EMR Master with TAMR CIDRS
resource "aws_security_group_rule" "hdfs_namenode_port_add_master_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 50070
  to_port           = 50070
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Hadoop HDFS NameNode - EMR Dashboard"
}

//Hadoop HDFS NameNode rule - Additional SG for EMR Master with TAMR SGs
resource "aws_security_group_rule" "hdfs_namenode_port_add_master_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 50070
  to_port                  = 50070
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Hadoop HDFS NameNode - EMR Dashboard"
}

//Spark HistoryServer rule - Additional SG for EMR Master with TAMR CIDRS
resource "aws_security_group_rule" "spark_historyserver_port_add_master_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 18080
  to_port           = 18080
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Spark HistoryServer - EMR Dashboard"
}

//Spark HistoryServer rule - Additional SG for EMR Master with TAMR SGs
resource "aws_security_group_rule" "spark_historyserver_port_add_master_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 18080
  to_port                  = 18080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Spark HistoryServer - EMR Dashboard"
}

//Hbase UI rule - Additional SG for EMR Master with TAMR CIDRS
resource "aws_security_group_rule" "hbase_ui_port_add_master_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided && local.running_hbase ? 1 : 0
  from_port         = 16010
  to_port           = 16010
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Hbase UI - EMR Dashboard"
}

//Hbase UI rule - Additional SG for EMR Master with TAMR SGs
resource "aws_security_group_rule" "hbase_ui_port_add_master_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided && local.running_hbase ? length(var.tamr_sgs) : 0
  from_port                = 16010
  to_port                  = 16010
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Hbase UI - EMR Dashboard"
}

//Hbase Master rule - Additional SG for EMR Master with TAMR CIDRS
resource "aws_security_group_rule" "hbase_master_port_add_master_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided && local.running_hbase ? 1 : 0
  from_port         = 16000
  to_port           = 16000
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Hbase Master - EMR Dashboard"
}

//Hbase Master rule - Additional SG for EMR Master with TAMR SGs
resource "aws_security_group_rule" "hbase_master_port_add_master_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided && local.running_hbase ? length(var.tamr_sgs) : 0
  from_port                = 16000
  to_port                  = 16000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Hbase Master - EMR Dashboard"
}

//Region Server rule - Additional SG for EMR Master with TAMR CIDRS
resource "aws_security_group_rule" "region_server_port_add_master_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 16020
  to_port           = 16020
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Region Server - EMR Dashboard"
}

//Region Server rule - Additional SG for EMR Master with TAMR SGs
resource "aws_security_group_rule" "region_server_port_add_master_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 16020
  to_port                  = 16020
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Region Server - EMR Dashboard"
}

//Region Server User rule - Additional SG for EMR Master with TAMR CIDRS
resource "aws_security_group_rule" "region_server_user_port_add_master_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 16030
  to_port           = 16030
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Region Server User - EMR Dashboard"
}

//Region Server User rule - Additional SG for EMR Master with TAMR SGs
resource "aws_security_group_rule" "region_server_user_port_add_master_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 16030
  to_port                  = 16030
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Region Server User - EMR Dashboard"
}

//Zookeeper client rule - Additional SG for EMR Master with TAMR CIDRS
resource "aws_security_group_rule" "zookeeper_client_port_add_master_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 2181
  to_port           = 2181
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Zookeeper client - EMR Dashboard"
}

//Zookeeper client rule - Additional SG for EMR Master with TAMR SGs
resource "aws_security_group_rule" "zookeeper_client_port_add_master_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 2181
  to_port                  = 2181
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Zookeeper client - EMR Dashboard"
}

//REST Server rule - Additional SG for EMR Master with TAMR CIDRS
resource "aws_security_group_rule" "rest_server_port_add_master_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 8070
  to_port           = 8070
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "REST Server - EMR Dashboard"
}

//REST Server rule - Additional SG for EMR Master with TAMR SGs
resource "aws_security_group_rule" "rest_server_port_add_master_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 8070
  to_port                  = 8070
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "REST Server - EMR Dashboard"
}

//REST UI rule - Additional SG for EMR Master with TAMR CIDRS
resource "aws_security_group_rule" "rest_ui_port_add_master_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 8085
  to_port           = 8085
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "REST UI - EMR Dashboard"
}

//REST UI rule - Additional SG for EMR Master with TAMR SGs
resource "aws_security_group_rule" "rest_ui_port_add_master_sg_tamr_sgs" {
  count                    = length(var.tamr_sgs) > 0 ? length(var.tamr_sgs) : 0
  from_port                = 8085
  to_port                  = 8085
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "REST UI - EMR Dashboard"
}

//Thrift Server rule - Additional SG for EMR Master with TAMR CIDRS
resource "aws_security_group_rule" "thrift_server_port_add_master_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 9090
  to_port           = 9090
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Thrift Server - EMR Dashboard"
}

//Thrift Server rule - Additional SG for EMR Master with TAMR SGs
resource "aws_security_group_rule" "thrift_server_port_add_master_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 9090
  to_port                  = 9090
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Thrift Server - EMR Dashboard"
}

//Thrift UI rule - Additional SG for EMR Master with TAMR CIDRS
resource "aws_security_group_rule" "thrift_ui_port_add_master_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 9095
  to_port           = 9095
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Thrift UI - EMR Dashboard"
}

//Thrift UI rule - Additional SG for EMR Master with TAMR SGs
resource "aws_security_group_rule" "thrift_ui_port_add_master_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 9095
  to_port                  = 9095
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Thrift UI - EMR Dashboard"
}

//HDFS RPC rule - Additional SG for EMR Master with TAMR CIDRS
resource "aws_security_group_rule" "hdfs_rpc_port_add_master_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 8020
  to_port           = 8020
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "HDFS RPC - EMR Dashboard"
}

//HDFS RPC rule - Additional SG for EMR Master with TAMR SGs
resource "aws_security_group_rule" "hdfs_rpc_port_add_master_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 8020
  to_port                  = 8020
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "HDFS RPC - EMR Dashboard"
}

//Egress SG rule for EMR Master Additional SG
resource "aws_security_group_rule" "egress_for_add_master_sg" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  description       = "Egress rule for EMR Master Additional SG"
}

//YARN NodeManager rule - Additional SG for EMR Core with TAMR CIDRS
resource "aws_security_group_rule" "yarn_nodemanager_port_add_core_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 8042
  to_port           = 8042
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_core.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "YARN NodeManager - EMR Dashboard"
}

//YARN NodeManager rule - Additional SG for EMR Core with TAMR SGs
resource "aws_security_group_rule" "yarn_nodemanager_port_add_core_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 8042
  to_port                  = 8042
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_core.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "YARN NodeManager - EMR Dashboard"
}

//Hadoop HDFS DataNode 1 rule - Additional SG for EMR Core with TAMR CIDRS
resource "aws_security_group_rule" "hdfs_datanode_1_port_add_core_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 50075
  to_port           = 50075
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_core.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Hadoop HDFS DataNode 1 - EMR Dashboard"
}

//Hadoop HDFS DataNode 1 rule - Additional SG for EMR Core with TAMR SGs
resource "aws_security_group_rule" "hdfs_datanode_1_port_add_coreg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 50075
  to_port                  = 50075
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_core.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Hadoop HDFS DataNode 1 - EMR Dashboard"
}

//Hadoop HDFS DataNode 2 rule - Additional SG for EMR Core with TAMR CIDRS
resource "aws_security_group_rule" "hdfs_datanode_2_port_add_core_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 50010
  to_port           = 50010
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_core.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Hadoop HDFS DataNode 2 - EMR Dashboard"
}

//Hadoop HDFS DataNode 2 rule - Additional SG for EMR Core with TAMR SGs
resource "aws_security_group_rule" "hdfs_datanode_2_port_add_core_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 50010
  to_port                  = 50010
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_core.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Hadoop HDFS DataNode 2 - EMR Dashboard"
}

//Region Server rule - Additional SG for EMR Core with TAMR CIDRS
resource "aws_security_group_rule" "region_server_port_add_core_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 16020
  to_port           = 16020
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_core.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Region Server - EMR Dashboard"
}

//Region Server rule - Additional SG for EMR Core with TAMR SGs
resource "aws_security_group_rule" "region_server_port_add_core_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 16020
  to_port                  = 16020
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_core.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Region Server - EMR Dashboard"
}

//Region Server rule - Additional SG for EMR Core with TAMR CIDRS for accessing HBase Metrics port
resource "aws_security_group_rule" "region_server_port_add_core_sg_tamr_cidrs_metrics" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 16030
  to_port           = 16030
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_core.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "Region Server - HBase Metrics"
}

//Region Server rule - Additional SG for EMR Core with TAMR SGs for accessing HBase Metrics port
resource "aws_security_group_rule" "region_server_port_add_core_sg_tamr_sgs_metrics" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 16030
  to_port                  = 16030
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_core.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "Region Server - HBase Metrics"
}

//Egress SG rule for EMR Core Additional SG
resource "aws_security_group_rule" "egress_for_add_core_sg" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.emr_additional_core.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  description       = "Egress rule for EMR Core Additional SG"
}

//SSH Access - Service Access SG TAMR CIDRS
resource "aws_security_group_rule" "ssh_service_access_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_service_access_sg.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "SSH Access for Tamr CIDRS"
}

//SSH Access - Service Access SG TAMR SGs
resource "aws_security_group_rule" "ssh_service_access_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_service_access_sg.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "SSH Access for Tamr SG"
}

//ICMP Access - Service Access SG TAMR CIDRS
resource "aws_security_group_rule" "icmp_service_access_sg_tamr_cidrs" {
  count             = local.tamr_cidrs_provided ? 1 : 0
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  security_group_id = aws_security_group.emr_service_access_sg.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "ICMP Access for Tamr CIDRS"
}

//ICMP Access - Service Access SG TAMR SGs
resource "aws_security_group_rule" "icmp_service_access_sg_tamr_sgs" {
  count                    = local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  security_group_id        = aws_security_group.emr_service_access_sg.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "ICMP Access for Tamr SG"
}

//HTTPS Access to master - Service Access SG TAMR SGs
resource "aws_security_group_rule" "new_https_service_access_sg_tamr_sgs" {
  from_port                = 9443
  to_port                  = 9443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_service_access_sg.id
  type                     = "ingress"
  source_security_group_id = aws_security_group.emr_managed_master.id
  description              = "HTTPS Access for Master SG"
}

//Egress SG rule for Service Access SG
resource "aws_security_group_rule" "egress_for_service_access_sg" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.emr_service_access_sg.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  description       = "Egress rule for Service Access SG"
}

// HTTP port required by Ganglia for TAMR CIDRs for EMR Master SG
resource "aws_security_group_rule" "emr_http_port_cidrs" {
  count             = var.enable_http_port && local.tamr_cidrs_provided ? 1 : 0
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_additional_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "HTTP port Tamr CIDRs"
}

// HTTP port required by Ganglia for TAMR SGs for EMR Master SG
resource "aws_security_group_rule" "emr_http_port_sgs" {
  count                    = var.enable_http_port && local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_additional_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "HTTP port for Tamr SGs"
}

// MapReduce JobHistory server webapp port for TAMR CIDRs for EMR Master SG
resource "aws_security_group_rule" "mr_jobhistory__port_cidrs" {
  count             = var.enable_http_port && local.tamr_cidrs_provided ? 1 : 0
  from_port         = 19888
  to_port           = 19888
  protocol          = "tcp"
  security_group_id = aws_security_group.emr_managed_master.id
  type              = "ingress"
  cidr_blocks       = var.tamr_cidrs
  description       = "MapReduce JobHistory server webapp port for Tamr CIDRs"
}

// MapReduce JobHistory server webapp port TAMR SGs for EMR Master SG
resource "aws_security_group_rule" "mr_jobhistory_port_sgs" {
  count                    = var.enable_http_port && local.tamr_sgs_provided ? length(var.tamr_sgs) : 0
  from_port                = 19888
  to_port                  = 19888
  protocol                 = "tcp"
  security_group_id        = aws_security_group.emr_managed_master.id
  type                     = "ingress"
  source_security_group_id = var.tamr_sgs[count.index]
  description              = "MapReduce JobHistory server webapp port for Tamr SGs"
}
