# Tamr AWS EMR Security Groups Terraform Module
This terraform module creates all the security groups and opens ports required for an AWS EMR cluster to run and connect to Tamr software.

# Example
```
module "emr_security_groups" {
  source = "git::git@github.com:Datatamer/terraform-emr-hbase.git//modules/aws-emr-sgs?ref=0.1.0"
  tamr_ips = ["1.2.3.4/32"]
  vpc_id = "vpc-examplevpcid"
}
``` 

# Variables
## Inputs:
* `vpc_id` (required): VPC Id where the Security Groups are to be created
* `emr_managed_master_sg_name` (optional): Name for the EMR managed master security group
* `emr_managed_core_sg_name`(optional): Name for the EMR managed core security group
* `emr_additional_master_sg_name`(optional): Name for the EMR additional master security group
* `emr_additional_core_sg_name`(optional): Name for the EMR additional core security group
* `emr_service_access_sg_name`(optional): Name for the EMR service access security group
* `tamr_ips` (optional): IP(s) for the Tamr software that would have access to the EMR cluster
* `tamr_sgs` (optional): Security Groups for the instances running the Tamr software that would have access to the EMR cluster
* `additional_tags` (optional): Tags that will be added to all the Security Groups created

```
Note: It is essential to have a Tamr instance IP or a Tamr instance Security Group mentioned in either `tamr-ips` or `tamr-sgs`, respectively, so that the Tamr instance has access to the EMR Hbase cluster.
```

## Outputs:
* `emr_managed_master_sg_id`: Security group id of the EMR Managed Master Security Group
* `emr_managed_core_sg_id`: Security group id of the EMR Managed Core Security Group
* `emr_additional_master_sg_id`: Security group id of the EMR Additional Master Security Group
* `emr_additional_core_sg_id`: Security group id of the EMR Additional Core Security Group
* `emr_service_access_sg_id`: Security group id of Service Access Security Group

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
