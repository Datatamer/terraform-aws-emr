/*
Assumptions:
 1. The EMR cluster is deployed in private subnet
 2. A Tamr Instance or A Tamr SG is deployed
*/

//Security groups for EMR cluster as specified:
//Reference 1: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-man-sec-groups.html#emr-sg-elasticmapreduce-master-private
//Reference 2: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-sg-specify.html

//Security group mapped to reference 1: ElasticMapReduce-Master-Private
resource "aws_security_group" "emr_managed_master" {
  vpc_id = var.vpc_id
  description = "EMR Managed Master Security Group"
  revoke_rules_on_delete = true
  name = "tamr-EMR-Master"

  tags = merge(
    {Author :"Tamr"},
    {Name: "Tamr EMR Managed Master SG"},
    var.additional_tags
  )
}

//Security group mapped to reference 1: ElasticMapReduce-Slave-Private
resource "aws_security_group" "emr_managed_agent" {
  vpc_id = var.vpc_id
  description = "EMR Managed Agent Security Group"
  revoke_rules_on_delete = true
  name = "tamr-EMR-Agent"
  tags = merge(
    {Author :"Tamr"},
    {Name: "Tamr EMR Managed Agent SG"},
    var.additional_tags
  )
}

//Security group mapped to reference 2: AdditionalMasterSecurityGroups
resource "aws_security_group" "emr_additional_master" {
  vpc_id = var.vpc_id
  name = "tamr-EMR-additional-Master"
  description = "EMR Additional Master Security Group for Tamr"
  revoke_rules_on_delete = true
  tags = merge(
    {Author :"Tamr"},
    {Name: "Tamr EMR Additional Master SG"},
    var.additional_tags
  )
}

//Security group mapped to reference 2: AdditionalSlaveSecurityGroups
resource "aws_security_group" "emr_additional_agent" {
  vpc_id = var.vpc_id
  name = "tamr-EMR-additional-Agent"
  description = "EMR Additional Agent Security Group for Tamr"
  revoke_rules_on_delete = true
  tags = merge(
    {Author :"Tamr"},
    {Name: "Tamr EMR Additional Agent SG"},
    var.additional_tags
  )
}

//Security group mapped to reference 1: ElasticMapReduce-ServiceAccess
resource "aws_security_group" "emr_service_access_sg" {
  name = "tamr-service-access-sg"
  description = "Security group for Tamr to access Hbase service"
  vpc_id = var.vpc_id
  revoke_rules_on_delete = true
  tags = merge(
    {Author :"Tamr"},
    {Name: "Tamr EMR Service Access SG"},
    var.additional_tags
  )
}
