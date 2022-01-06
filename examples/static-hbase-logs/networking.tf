module "sg-ports" {
  # source               = "git::https://github.com/Datatamer/terraform-aws-emr.git//modules/aws-emr-ports?ref=6.2.0"
  source       = "../../modules/aws-emr-ports"
  applications = local.this_application
}

module "aws-emr-sg-master" {
  source              = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
  #ingress_security_groups = module.sg_vm_web.security_group_ids
  ingress_security_groups = []
  egress_cidr_blocks      = var.egress_cidr_blocks
  ingress_ports           = module.sg-ports.ingress_master_ports
  sg_name_prefix          = format("%s-%s", var.name_prefix, "-master")
  egress_protocol         = "all"
  ingress_protocol        = "tcp"
}

module "aws-emr-sg-core" {
  source              = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
  #ingress_security_groups = module.sg_vm_web.security_group_ids
  ingress_security_groups = []
  egress_cidr_blocks      = var.egress_cidr_blocks
  ingress_ports           = module.sg-ports.ingress_core_ports
  sg_name_prefix          = format("%s-%s", var.name_prefix, "-core")
  egress_protocol         = "all"
  ingress_protocol        = "tcp"
}

module "aws-emr-sg-service-access" {
  source              = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
  egress_cidr_blocks  = var.egress_cidr_blocks
  ingress_ports       = module.sg-ports.ingress_service_access_ports
  sg_name_prefix      = format("%s-%s", var.name_prefix, "-service-access")
  egress_protocol     = "all"
  ingress_protocol    = "tcp"
}

#Creates a security group for the VPC Interface Endpoint
module "aws-endpoint-sg" {
  source        = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id        = var.vpc_id
  ingress_ports = [443]
  ingress_security_groups = [module.aws-emr-sg-master.security_group_ids[0],
  module.aws-emr-sg-core.security_group_ids[0]]
  sg_name_prefix   = format("%s-%s", var.name_prefix, "interface-endpoint-sg")
  ingress_protocol = "tcp"
  egress_protocol  = "all"
  tags             = var.tags
}

#Create VPC Interface Endpoint for Cloudwatch
module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  vpc_id = var.vpc_id

  endpoints = {
    logs = {
      service_type        = "Interface"
      service             = "logs"
      tags                = { Name = format("%s-%s", var.name_prefix, "cloudwatch-vpc-endpoint") }
      private_dns_enabled = true
      security_group_ids  = module.aws-endpoint-sg.security_group_ids
      subnet_ids          = [var.application_subnet_id]
    },
  }
  tags = var.tags
}
