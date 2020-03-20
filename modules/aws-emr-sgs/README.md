# Tamr AWS EMR Security Groups Terraform Module

## Description
This terraform module creates all the security groups and opens ports required for an AWS EMR cluster to run and connect to Tamr software.

## Assumptions
* The EMR cluster is deployed in a private subnet of a VPC.
* An instance running the Tamr software or a Security Group that will be connected to the Tamr instance will be deployed.

## Variables
* `vpc-id` (required): VPC Id where the Security Groups are to be created
* `tamr-ips` (optional): IP(s) for the Tamr software that would have access to the EMR cluster
* `tamr-sgs` (optional): Security Groups for the instances running the Tamr software that would have access to the EMR cluster
* `additional-tags` (optional): Tags that will be added to all the Security Groups created

```
Note: It is essential to have a Tamr instance IP or a Tamr instance Security Group mentioned in either `tamr-ips` or `tamr-sgs`, respectively, so that the Tamr instance has access to the EMR Hbase cluster.
```

## AWS Resources created
This terraform module will create 5 Security Groups
* `tamr-EMR-Master`: The EMR Managed Master Security Group
* `tamr-EMR-Agent`: The EMR Managed Agent Security Group
* `tamr-EMR-additional-master`: The security group to connect EMR Master to the Tamr Software
* `tamr-EMR-additional-agent`: The security group to connect EMR Agent to the Tamr Software
* `tamr-service-access-sg`: The security group for EMR Hbase Dashboard to give access to Tamr Software

This terraform module alse creates 7 Security Group Rules (6 ingress, 1 egress) for `tamr-EMR-Agent` Security Group because `tamr-EMR-Master` and `tamr-EMR-Agent` are interdependent on each other and so require either one of them to have its rules created externally to avoid `terraform cycle error`.

## File structure
```
aws-emr-sgs
├── README.md
├── examples/
├── main.tf
├── outputs.tf
├── security-group-rules.tf
└── variables.tf
```

## Usage Example
main.tf: 
```
provider "aws" {
  region = var.region
}

module "emr_security_groups" {
  source = "../../../shared_files/modules/aws-emr-sgs"
  tamr-ips = var.tamr-ips
  tamr-sgs = var.tamr-sgs
  vpc-id = var.vpc_id
  additional-tags = var.tags
}
``` 

## Reference documents:
* AWS EMR Security Groups: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-man-sec-groups.html
* AWS EMR Additional Security Groups: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-sg-specify.html
* Terraform module structure: https://www.terraform.io/docs/modules/index.html#standard-module-structure