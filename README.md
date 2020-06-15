# TAMR AWS EMR Hbase root module
This module creates the entire AWS infrastructure required for Tamr to work with AWS EMR Hbase

# Example
A complete working example is specified in the `/examples` directory.

# Resources Created
This modules creates:
* 2 S3 buckets
    * One S3 bucket for EMR Hbase logs
    * One S3 bucket for EMR Hbase Root Directory
* 5 Security Groups
    * One security group for EMR Managed Master instance(s)
    * One security group for EMR Managed Core instance(s)
    * One security group for additional ports for Master instance(s)
    * One security group for additional ports for Core instance(s)
    * One service access security group that can be attached to any instance
* Security group rules. The number of the security group rules varies based on the number of CIDRs or source SGs provided.
* 2 IAM Policies:
    * Minimum required EMR service policy
    * Minimum required EMR EC2 policy
* 2 IAM roles:
    * Tamr EMR service IAM role
    * Tamr EMR EC2 IAM role
* 1 IAM instance profile for EMR EC2 instances
* 1 Dynamodb table for EMRFS
* 1 EMR Hbase Cluster

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_account\_id | Account ID of the AWS account | `string` | n/a | yes |
| bucket\_name\_for\_hbase\_root\_dir | S3 bucket name for EMR Hbase root directory | `string` | n/a | yes |
| bucket\_name\_for\_logs | S3 bucket name for EMR Hbase logs | `string` | n/a | yes |
| emr\_hbase\_config\_file\_path | Path to the EMR Hbase config file. Please include the file name as well. | `string` | n/a | yes |
| key\_pair\_name | Name of the Key Pair that will be attached to the EC2 instances | `string` | n/a | yes |
| subnet\_id | ID of the subnet where the emr cluster will be created | `string` | n/a | yes |
| vpc\_id | VPC id of the network | `string` | n/a | yes |
| additional\_tags | Additional tags to be attached to the resources created | `map(string)` | `{}` | no |
| applications | List of applications to run on EMR | `list(string)` | <pre>[<br>  "Hbase"<br>]</pre> | no |
| aws\_region\_of\_dynamodb\_table | AWS region where the Dynamodb table for EMRFS metadata is located | `string` | `"us-east-1"` | no |
| cluster\_name | Name for the EMR Hbase cluster to be created | `string` | `"TAMR-EMR-Hbase-Cluster"` | no |
| core\_ebs\_size | The volume size, in gibibytes (GiB). | `string` | `"500"` | no |
| core\_ebs\_type | Type of volumes to attach to the core nodes. Valid options are gp2, io1, standard and st1 | `string` | `"gp2"` | no |
| core\_ebs\_volumes\_count | Number of volumes to attach to the core nodes | `number` | `1` | no |
| core\_group\_instance\_count | Number of Amazon EC2 instances used to execute the job flow | `number` | `1` | no |
| core\_instance\_group\_name | Name for the core instance group | `string` | `"CoreInstanceGroup"` | no |
| core\_instance\_type | The EC2 instance type of the core nodes | `string` | `"m4.xlarge"` | no |
| emr\_additional\_core\_sg\_name | Name for the EMR additional core security group | `string` | `"TAMR-EMR-Core-Additional"` | no |
| emr\_additional\_master\_sg\_name | Name for the EMR additional master security group | `string` | `"TAMR-EMR-Master-Additional"` | no |
| emr\_ec2\_iam\_policy\_name | Name for the IAM policy attached to the EMR Service role | `string` | `"tamr-emr-ec2-policy"` | no |
| emr\_ec2\_instance\_profile\_name | Name for the new instance profile for the EMR Hbase EC2 instances | `string` | `"tamr_emr_ec2_instance_profile"` | no |
| emr\_ec2\_role\_name | Name for the new iam role for the EMR Hbase EC2 instances | `string` | `"tamr_emr_ec2_role"` | no |
| emr\_managed\_core\_sg\_name | Name for the EMR managed core security group | `string` | `"TAMR-EMR-Core"` | no |
| emr\_managed\_master\_sg\_name | Name for the EMR managed master security group | `string` | `"TAMR-EMR-Master"` | no |
| emr\_service\_access\_sg\_name | Name for the EMR service access security group | `string` | `"TAMR-EMR-Service-Access"` | no |
| emr\_service\_iam\_policy\_name | Name for the IAM policy attached to the EMR Service role | `string` | `"tamr-emr-hbase-policy"` | no |
| emr\_service\_role\_name | Name for the new iam service role for the EMR Hbase cluster | `string` | `"tamr_emr_service_role"` | no |
| emrfs\_metadata\_read\_capacity | Read capacity units of the dynamodb table used for EMRFS metadata | `number` | `600` | no |
| emrfs\_metadata\_table\_name | Table name of EMRFS metadata table in Dynamodb | `string` | `"EmrFSMetadata"` | no |
| emrfs\_metadata\_write\_capacity | Write capacity units of the dynamodb table used for EMRFS metadata | `number` | `300` | no |
| master\_ebs\_size | The volume size, in gibibytes (GiB). | `string` | `"100"` | no |
| master\_ebs\_type | Type of volumes to attach to the master nodes. Valid options are gp2, io1, standard and st1 | `string` | `"gp2"` | no |
| master\_ebs\_volumes\_count | Number of volumes to attach to the master nodes | `number` | `1` | no |
| master\_group\_instance\_count | Number of instances for the master instance group. Must be 1 or 3. | `number` | `1` | no |
| master\_instance\_group\_name | Name for the master instance group | `string` | `"MasterInstanceGroup"` | no |
| master\_instance\_type | The EC2 instance type of the master nodes | `string` | `"m4.xlarge"` | no |
| release\_label | The release label for the Amazon EMR release. | `string` | `"emr-5.11.2"` | no |
| tamr\_cidrs | List of CIDRs for Tamr | `list(string)` | `[]` | no |
| tamr\_sgs | Security Groups for the Tamr Instance | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| emr\_additional\_core\_sg\_id | Security group id of the EMR Additional Core Security Group |
| emr\_additional\_master\_sg\_id | Security group id of the EMR Additional Master Security Group |
| emr\_ec2\_instance\_profile\_arn | ARN of the EMR Hbase service role created |
| emr\_ec2\_role\_arn | ARN of the EMR Hbase role created for EC2 instances |
| emr\_managed\_core\_sg\_id | Security group id of the EMR Managed Core Security Group |
| emr\_managed\_master\_sg\_id | Security group id of the EMR Managed Master Security Group |
| emr\_service\_access\_sg\_id | Security group id of Service Access Security Group |
| emr\_service\_role\_arn | ARN of the EMR Hbase service role created |
| s3\_bucket\_name\_for\_hbase\_rootdir | S3 bucket name for EMR Hbase root directory |
| s3\_bucket\_name\_for\_logs | S3 bucket name for EMR logs |
| tamr\_emr\_cluster\_id | Identifier for the AWS EMR cluster created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [Terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [AWS EMR HBase](https://aws.amazon.com/emr/features/hbase/)
* [AWS EMR Cluster Terraform Docs](https://www.terraform.io/docs/providers/aws/r/emr_cluster.html)
* [Default IAM roles for EMR](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-roles.html)
* [Service role for EMR](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-role.html)
* [EC2 role for EMR (Instance Profile)](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-role-for-ec2.html)
* [Best Practices for EMR](https://aws.amazon.com/blogs/big-data/best-practices-for-securing-amazon-emr/)
* [AWS EMR Security Groups](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-man-sec-groups.html)
* [AWS EMR Additional Security Groups](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-sg-specify.html)

# Development
## Releasing new versions
* Updated version contained in `VERSION`
* Documented changes in `CHANGELOG.md`

# License
Apache 2 Licensed. See LICENSE for full details.
