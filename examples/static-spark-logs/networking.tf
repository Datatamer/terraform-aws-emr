module "sg-ports" {
  # source  = "git::https://github.com/Datatamer/terraform-aws-emr.git//modules/aws-emr-ports?ref=9.0.0"
  source       = "../../modules/aws-emr-ports"
  applications = local.this_application
}

module "aws-emr-sg-master" {
  source              = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.1"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
  egress_cidr_blocks  = var.egress_cidr_blocks
  ingress_ports       = module.sg-ports.ingress_master_ports
  sg_name_prefix      = format("%s-%s", var.name_prefix, "-master")
  egress_protocol     = "all"
  ingress_protocol    = "tcp"
}

module "aws-emr-sg-core" {
  source              = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.1"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
  egress_cidr_blocks  = var.egress_cidr_blocks
  ingress_ports       = module.sg-ports.ingress_core_ports
  sg_name_prefix      = format("%s-%s", var.name_prefix, "-core")
  egress_protocol     = "all"
  ingress_protocol    = "tcp"
}

module "aws-emr-sg-service-access" {
  source              = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.1"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
  egress_cidr_blocks  = var.egress_cidr_blocks
  ingress_ports       = module.sg-ports.ingress_service_access_ports
  sg_name_prefix      = format("%s-%s", var.name_prefix, "-service-access")
  egress_protocol     = "all"
  ingress_protocol    = "tcp"
}
