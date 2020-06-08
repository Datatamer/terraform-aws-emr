# Tamr AWS EMR Security Groups Terraform Module
This terraform module creates all the security groups and opens ports required for an AWS EMR cluster to run and connect to Tamr software.

# Example
```
module "emr_security_groups" {
  source = "git::git@github.com:Datatamer/terraform-emr-hbase.git//modules/aws-emr-sgs?ref=0.4.0"
  tamr_ips = ["1.2.3.4/32"]
  vpc_id = "vpc-examplevpcid"
}
``` 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc\_id | VPC ID | `string` | n/a | yes |
| additional\_tags | Additional tags to be attached to the resources created | `map(string)` | `{}` | no |
| emr\_additional\_core\_sg\_name | Name for the EMR additional core security group | `string` | `"TAMR-EMR-Core-Additional"` | no |
| emr\_additional\_master\_sg\_name | Name for the EMR additional master security group | `string` | `"TAMR-EMR-Master-Additional"` | no |
| emr\_managed\_core\_sg\_name | Name for the EMR managed core security group | `string` | `"TAMR-EMR-Core"` | no |
| emr\_managed\_master\_sg\_name | Name for the EMR managed master security group | `string` | `"TAMR-EMR-Master"` | no |
| emr\_service\_access\_sg\_name | Name for the EMR service access security group | `string` | `"TAMR-EMR-Service-Access"` | no |
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

# AWS Resources created
This terraform module creates 5 Security Groups:
* The EMR Managed Master Security Group for the master instance(s)
* The EMR Managed Core Security Group for the core instance(s)
* The additional security group for the master instance(s)
* The additional security group for the core instance(s)
* The service access security group that can be attached to any instance for SSH or ICMP

This terraform module also creates several Security Group Rules. The number of Security Group rules vary depending on the IP/SG provided in CIDR/Source, respectively.

# Reference documents:
* AWS EMR Security Groups: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-man-sec-groups.html
* AWS EMR Additional Security Groups: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-sg-specify.html
* Terraform module structure: https://www.terraform.io/docs/modules/index.html#standard-module-structure
