//Security group mapped to reference 1: ElasticMapReduce-Master-Private
resource "aws_security_group" "emr_managed_master" {
  vpc_id                 = var.vpc_id
  description            = "EMR Managed Master Security Group"
  revoke_rules_on_delete = true
  name                   = var.emr_managed_master_sg_name
  tags = var.additional_tags
}

//Security group mapped to reference 1: ElasticMapReduce-Slave-Private
resource "aws_security_group" "emr_managed_core" {
  vpc_id                 = var.vpc_id
  description            = "EMR Managed Core Security Group"
  revoke_rules_on_delete = true
  name                   = var.emr_managed_core_sg_name
  tags                   = var.additional_tags
}

//Security group mapped to reference 2: AdditionalMasterSecurityGroups
resource "aws_security_group" "emr_additional_master" {
  vpc_id                 = var.vpc_id
  name                   = var.emr_additional_master_sg_name
  description            = "EMR Additional Master Security Group for Tamr"
  revoke_rules_on_delete = true
  tags                   = var.additional_tags
}

//Security group mapped to reference 2: AdditionalSlaveSecurityGroups
resource "aws_security_group" "emr_additional_core" {
  vpc_id                 = var.vpc_id
  name                   = var.emr_additional_core_sg_name
  description            = "EMR Additional Core Security Group for Tamr"
  revoke_rules_on_delete = true
  tags                   = var.additional_tags
}

//Security group mapped to reference 1: ElasticMapReduce-ServiceAccess
resource "aws_security_group" "emr_service_access_sg" {
  name                   = var.emr_service_access_sg_name
  description            = "Security group for Tamr to access Hbase/Spark service"
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true
  tags                   = var.additional_tags
}
