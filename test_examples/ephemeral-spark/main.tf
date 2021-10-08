locals {
  all_tags = merge({
    Terraform = "true"
    Terratest = "true"
    },
    var.tags,
  var.abac_tags)
}

module "example_ephem_spark" {
  source = "../../examples/ephemeral-spark"

  bucket_name_for_logs           = var.bucket_name_for_logs
  bucket_name_for_root_directory = var.bucket_name_for_root_directory
  name_prefix                    = var.name_prefix
  tags                           = local.all_tags
  abac_valid_tags                = var.abac_valid_tags
  vpc_id                         = module.vpc.vpc_id

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
  public_subnets  = var.public_subnets

  enable_ipv6 = false

  enable_nat_gateway = false
  single_nat_gateway = false

  tags = local.all_tags
}

data "aws_region" "current" {}
