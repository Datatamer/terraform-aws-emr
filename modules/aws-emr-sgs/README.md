# Tamr AWS EMR Security Groups Terraform Module
This terraform module creates all the security groups and opens ports required for an AWS EMR cluster to run and connect to Tamr software.

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "emr_security_groups" {
  source       = "git::git@github.com:Datatamer/terraform-aws-emr.git//modules/aws-emr-sgs?ref=2.0.0"
  applications = ["HBase"]
  tamr_ips     = ["1.2.3.4/32"]
  vpc_id       = "vpc-examplevpcid"
}
```
## Minimal
This example directly invokes this submodule.
- [Ephemeral Spark Example](https://github.com/Datatamer/terraform-aws-emr/tree/master/examples/ephemeral-spark)


# Resources created
This terraform module creates:
* 5 Security Groups:
  * The EMR Managed Master Security Group for the master instance(s)
  * The EMR Managed Core Security Group for the core instance(s)
  * The additional security group for the master instance(s)
  * The additional security group for the core instance(s)
  * The service access security group that can be attached to any instance for SSH or ICMP
* Several Security Group Rules. The number of Security Group rules vary depending on the IP/SG provided in CIDR/Source, respectively.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 2.45.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.45.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| applications | List of applications to run on EMR | `list(string)` | n/a | yes |
| vpc\_id | VPC ID of the network | `string` | n/a | yes |
| additional\_tags | Additional tags to be attached to the resources created | `map(string)` | `{}` | no |
| emr\_additional\_core\_sg\_name | Name for the EMR additional core security group | `string` | `"TAMR-EMR-Core-Additional"` | no |
| emr\_additional\_master\_sg\_name | Name for the EMR additional master security group | `string` | `"TAMR-EMR-Master-Additional"` | no |
| emr\_managed\_core\_sg\_name | Name for the EMR managed core security group | `string` | `"TAMR-EMR-Core"` | no |
| emr\_managed\_master\_sg\_name | Name for the EMR managed master security group | `string` | `"TAMR-EMR-Master"` | no |
| emr\_service\_access\_sg\_name | Name for the EMR service access security group | `string` | `"TAMR-EMR-Service-Access"` | no |
| enable\_http\_port | EMR services like Ganglia run on the http port | `bool` | `false` | no |
| tamr\_cidrs | List of CIDRs for Tamr | `list(string)` | `[]` | no |
| tamr\_sgs | Security Group for the Tamr Instance | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| emr\_additional\_core\_sg\_id | Security group id of the EMR Additional Core Security Group |
| emr\_additional\_master\_sg\_id | Security group id of the EMR Additional Master Security Group |
| emr\_managed\_core\_sg\_id | Security group id of the EMR Managed Core Security Group |
| emr\_managed\_master\_sg\_id | Security group id of the EMR Managed Master Security Group |
| emr\_service\_access\_sg\_id | Security group id of Service Access Security Group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Reference documents:
* AWS EMR Security Groups: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-man-sec-groups.html
* AWS EMR Additional Security Groups: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-sg-specify.html
* Terraform module structure: https://www.terraform.io/docs/modules/index.html#standard-module-structure
