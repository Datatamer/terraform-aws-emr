# Terraform AWS EMR Cluster Terraform Module
This terraform module creates a EMR cluster.

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "emr-cluster" {
  source                                  = "git::git@github.com:Datatamer/terraform-aws-emr.git//modules/aws-emr-cluster?ref=0.12.0"

  # Cluster configuration
  cluster_name                   = "example-cluster"
  applications                   = ["Spark", "HBase"]
  bucket_name_for_root_directory = module.emr-rootdir-bucket.bucket_name
  bucket_name_for_logs           = module.emr-logs-bucket.bucket_name

  # Cluster instances
  subnet_id                   = "example-subnet"
  key_pair_name               = module.emr_key_pair.this_key_pair_key_name
  master_instance_group_name  = "Example-MasterInstanceGroup"
  core_instance_group_name    = "Example-CoreInstanceGroup"

  # DynamoDB
  emrfs_metadata_table_name     = module.emrfs-dynamodb.emrfs_dynamodb_table_name

  # Security groups
  emr_managed_master_sg_id    = module.emr-sgs.emr_managed_master_sg_id
  emr_additional_master_sg_id = module.emr-sgs.emr_additional_master_sg_id
  emr_managed_core_sg_id      = module.emr-sgs.emr_managed_core_sg_id
  emr_additional_core_sg_id   = module.emr-sgs.emr_additional_core_sg_id
  emr_service_access_sg_id    = module.emr-sgs.emr_service_access_sg_id

  # IAM
  emr_service_role_arn         = module.emr-iam.emr_service_role_arn
  emr_ec2_instance_profile_arn = module.emr-iam.emr_ec2_instance_profile_arn
}
```

# Resources Created
This module creates:
* a EMR cluster

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
| bucket\_name\_for\_logs | S3 bucket name for cluster logs. | `string` | n/a | yes |
| bucket\_name\_for\_root\_directory | S3 bucket name for storing root directory | `string` | n/a | yes |
| emr\_additional\_core\_sg\_id | Security group id of the EMR Additional Core Security Group | `string` | n/a | yes |
| emr\_additional\_master\_sg\_id | Security group id of the EMR Additional Master Security Group | `string` | n/a | yes |
| emr\_ec2\_instance\_profile\_arn | ARN of the EMR EC2 instance profile | `string` | n/a | yes |
| emr\_managed\_core\_sg\_id | Security group id of the EMR Managed Core Security Group | `string` | n/a | yes |
| emr\_managed\_master\_sg\_id | Security group id of the EMR Managed Master Security Group | `string` | n/a | yes |
| emr\_service\_access\_sg\_id | Security group id of Service Access Security Group | `string` | n/a | yes |
| emr\_service\_role\_arn | ARN of the IAM service role for the EMR cluster | `string` | n/a | yes |
| emrfs\_metadata\_table\_name | Table name of EMRFS metadata table in DynamoDB | `string` | n/a | yes |
| key\_pair\_name | Name of the Key Pair that will be attached to the EC2 instances | `string` | n/a | yes |
| subnet\_id | ID of the subnet where the EMR cluster will be created | `string` | n/a | yes |
| additional\_tags | Additional tags to be attached to the resources created | `map(string)` | `{}` | no |
| bucket\_path\_to\_logs | Path in logs bucket to store cluster logs e.g. mycluster/logs | `string` | `""` | no |
| cluster\_name | Name for the EMR cluster to be created | `string` | `"TAMR-EMR-Cluster"` | no |
| core\_ebs\_size | The volume size, in gibibytes (GiB). | `string` | `"500"` | no |
| core\_ebs\_type | Type of volumes to attach to the core nodes. Valid options are gp2, io1, standard and st1 | `string` | `"gp2"` | no |
| core\_ebs\_volumes\_count | Number of volumes to attach to the core nodes | `number` | `1` | no |
| core\_group\_instance\_count | Number of Amazon EC2 instances used to execute the job flow | `number` | `1` | no |
| core\_instance\_group\_name | Name for the core instance group | `string` | `"CoreInstanceGroup"` | no |
| core\_instance\_type | The EC2 instance type of the core nodes | `string` | `"m4.xlarge"` | no |
| create\_static\_cluster | True if the module should create a static cluster. False if the module should create supporting infrastructure but not the cluster itself. | `bool` | `true` | no |
| json\_configuration\_bucket\_key | Key (i.e. path) of JSON configuration bucket object in the root directory bucket | `string` | `"config.json"` | no |
| master\_ebs\_size | The volume size, in gibibytes (GiB). | `string` | `"100"` | no |
| master\_ebs\_type | Type of volumes to attach to the master nodes. Valid options are gp2, io1, standard and st1 | `string` | `"gp2"` | no |
| master\_ebs\_volumes\_count | Number of volumes to attach to the master nodes | `number` | `1` | no |
| master\_group\_instance\_count | Number of instances for the master instance group. Must be 1 or 3. | `number` | `1` | no |
| master\_instance\_group\_name | Name for the master instance group | `string` | `"MasterInstanceGroup"` | no |
| master\_instance\_type | The EC2 instance type of the master nodes | `string` | `"m4.xlarge"` | no |
| release\_label | The release label for the Amazon EMR release. | `string` | `"emr-5.29.0"` | no |
| utility\_script\_bucket\_key | Key (i.e. path) to upload the utility script to | `string` | `"util/upload_hbase_config.sh"` | no |

## Outputs

| Name | Description |
|------|-------------|
| core\_ebs\_size | The core EBS volume size, in gibibytes (GiB). |
| core\_ebs\_type | The core EBS volume size, in gibibytes (GiB). |
| core\_ebs\_volumes\_count | Number of volumes to attach to the core nodes |
| core\_group\_instance\_count | Number of cores configured to execute the job flow |
| core\_instance\_type | The EC2 instance type of the core nodes |
| log\_uri | The path to the S3 location where logs for this cluster are stored. |
| master\_ebs\_size | The master EBS volume size, in gibibytes (GiB). |
| master\_ebs\_type | Type of volumes to attach to the master nodes. Valid options are gp2, io1, standard and st1 |
| master\_ebs\_volumes\_count | Number of volumes to attach to the master nodes |
| master\_instance\_type | The EC2 instance type of the master nodes |
| release\_label | The release label for the Amazon EMR release. |
| subnet\_id | ID of the subnet where EMR cluster was created |
| tamr\_emr\_cluster\_id | Identifier for the AWS EMR cluster created |
| tamr\_emr\_cluster\_name | Name of the AWS EMR cluster created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [AWS EMR Cluster Terraform Docs](https://www.terraform.io/docs/providers/aws/r/emr_cluster.html)
* [AWS EMR HBase](https://aws.amazon.com/emr/features/hbase/)

# License
Apache 2 Licensed. See LICENSE for full details.
