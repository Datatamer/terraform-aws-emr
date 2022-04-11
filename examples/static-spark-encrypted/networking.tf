module "sg-ports" {
  # source  = "git::https://github.com/Datatamer/terraform-aws-emr.git//modules/aws-emr-ports?ref=7.3.2"
  source       = "../../modules/aws-emr-ports"
  applications = local.this_application
}

module "aws-emr-sg-master" {
  source              = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
  egress_cidr_blocks  = var.egress_cidr_blocks
  ingress_ports       = module.sg-ports.ingress_master_ports
  sg_name_prefix      = format("%s-%s", var.name_prefix, "-master")
  egress_protocol     = "all"
  ingress_protocol    = "tcp"
}

module "aws-emr-sg-core" {
  source              = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
  egress_cidr_blocks  = var.egress_cidr_blocks
  ingress_ports       = module.sg-ports.ingress_core_ports
  sg_name_prefix      = format("%s-%s", var.name_prefix, "-core")
  egress_protocol     = "all"
  ingress_protocol    = "tcp"
}

module "aws-emr-sg-service-access" {
  source                  = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id                  = var.vpc_id
  ingress_security_groups = module.aws-emr-sg-master.security_group_ids
  ingress_ports           = module.sg-ports.ingress_service_access_ports
  sg_name_prefix          = format("%s-%s", var.name_prefix, "-service-access")
  egress_protocol         = "all"
  ingress_protocol        = "tcp"
}

# Creates KMS VPC Endpoint
# module "endpoints" {
#   source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

#   vpc_id = var.vpc_id

#   endpoints = {
#     kms = {
#       service_type        = "Interface"
#       service             = "kms"
#       tags                = { Name = format("%s-%s", var.name_prefix, "kmss-interface-endpoint") }
#       private_dns_enabled = true
#       security_group_ids  = [aws_security_group.kms_interface_endpoint.id]
#       subnet_ids          = [var.compute_subnet_id]
#     }
#   }
#   tags = var.tags
# }

# # Creates KMS VPC Endpoint Security Group
# resource "aws_security_group" "kms_interface_endpoint" {
#   name        = format("%s-%s", var.name_prefix, "kms-interface-endpoint-sg")
#   description = "Security Group to be attached to the KMS Endpoint interface, which allows TCP traffic to the KMS service."
#   vpc_id      = var.vpc_id

#   ingress {
#     description = "KMS API"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "TCP"
#     cidr_blocks = [var.compute_subnet_cidr_block]
#   }
#   tags = var.tags
# }
