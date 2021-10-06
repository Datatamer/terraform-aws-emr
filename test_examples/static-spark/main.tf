locals {
  all_tags = merge({
    Terraform = "true"
    Terratest = "true"
    },
    var.tags,
  var.abac_tags)
}

module "example_static_spark" {
  source = "../../examples/static-spark"

  bucket_name_for_logs           = var.bucket_name_for_logs
  bucket_name_for_root_directory = var.bucket_name_for_root_directory
  name_prefix                    = var.name_prefix
  ingress_cidr_blocks            = var.ingress_cidr_blocks
  egress_cidr_blocks             = var.egress_cidr_blocks
  tags                           = local.all_tags
  abac_valid_tags                = var.abac_valid_tags
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]

  depends_on = [
    module.vpc
  ]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.1.0"

  name = "terratest-vpc"
  cidr = var.vpc_cidr

  azs             = ["${data.aws_region.current.name}a", "${data.aws_region.current.name}b"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_ipv6 = false

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = local.all_tags
}

data "aws_region" "current" {}
