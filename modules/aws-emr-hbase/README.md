# Tamr AWS EMR HBase Terraform Module
This terraform module creates an Apache HBase cluster on Amazon EMR.

# Example
main.tf:
```
module "emr_hbase_module" {
  source = "git::git@github.com:Datatamer/terraform-emr-hbase.git//modules/aws-emr-hbase?ref=0.4.0"
  name = "example-hbase-cluster"
  subnet_id = "subnet-examplesubnet"
  emr_managed_master_security_group = "sg-examplesg1"
  additional_master_security_groups = "sg-examplesg2"
  emr_managed_slave_security_group = "sg-examplesg3"
  additional_slave_security_groups = "sg-examplesg4"
  service_access_security_group = "sg-examplesg5"
  instance_profile = "arn:aws:iam::123456789098:instance-profile/example_emr_instance_profile"
  service_role = "arn:aws:iam::123456789098:role/example_emr_service_role"
  key_name = "exampleKeyPair"
  emr_hbase_s3_bucket_logs = "emr-hbase-logs-example"
  emr_hbase_s3_bucket_root_dir = "emr-hbase-rootdir-example"
  path_to_config_file = "path/to/config/file"
}
```

# Resources Created
This terraform module creates:
* 1 AWS EMR Cluster with Apache Hbase application installed. 

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
| time | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_master\_security\_groups | String containing a comma separated list of additional Amazon EC2 security group IDs for the master node | `string` | n/a | yes |
| additional\_slave\_security\_groups | String containing a comma separated list of additional Amazon EC2 security group IDs for the slave nodes as a comma separated string | `string` | n/a | yes |
| emr\_hbase\_s3\_bucket\_logs | S3 bucket for logs for EMR Hbase | `string` | n/a | yes |
| emr\_hbase\_s3\_bucket\_root\_dir | S3 bucket for root directory for EMR Hbase | `string` | n/a | yes |
| emr\_managed\_master\_security\_group | Identifier of the Amazon EC2 EMR-Managed security group for the master node | `string` | n/a | yes |
| emr\_managed\_slave\_security\_group | Identifier of the Amazon EC2 EMR-Managed security group for the slave nodes | `string` | n/a | yes |
| instance\_profile | ARN of the Instance Profile for EC2 instances of the cluster assume this role | `string` | n/a | yes |
| key\_name | Amazon EC2 key pair that can be used to ssh to the master node as the user called hadoop | `string` | n/a | yes |
| path\_to\_config\_file | Path to the EMR Hbase JSON config file. Please include filename too. | `string` | n/a | yes |
| service\_access\_security\_group | Identifier of the Amazon EC2 service-access security group - required when the cluster runs on a private subnet | `string` | n/a | yes |
| service\_role | ARN of the service role for AWS EMR cluster | `string` | n/a | yes |
| subnet\_id | VPC subnet id where you want the job flow to launch | `string` | n/a | yes |
| applications | List of applications to run on EMR | `list(string)` | <pre>[<br>  "Hbase"<br>]</pre> | no |
| core\_group\_instance\_count | Number of Amazon EC2 instances used to execute the job flow | `number` | `1` | no |
| core\_instance\_group\_name | Friendly name given to the instance group. | `string` | `"CoreInstanceGroup"` | no |
| core\_instance\_type | The EC2 instance type of the core nodes | `string` | `"m4.xlarge"` | no |
| emrfs\_metadata\_read\_capacity | Read capacity units of the dynamodb table used for EMRFS metadata | `number` | `600` | no |
| emrfs\_metadata\_table\_name | Table name of the dynamodb table for EMRFS metadata | `string` | `"EmrFSMetadata"` | no |
| emrfs\_metadata\_write\_capacity | Write capacity units of the dynamodb table used for EMRFS metadata | `number` | `300` | no |
| master\_group\_instance\_count | Number of instances for the master instance group. Must be 1 or 3. | `number` | `1` | no |
| master\_instance\_group\_name | Friendly name given to the instance group. | `string` | `"MasterInstanceGroup"` | no |
| master\_instance\_type | The EC2 instance type of the master nodes | `string` | `"m4.xlarge"` | no |
| name | Name of EMR HBase cluster | `string` | `"TAMR-EMR-Hbase-Cluster"` | no |
| release\_label | The release label for the Amazon EMR release. | `string` | `"emr-5.11.2"` | no |
| tags | Map of tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| tamr\_emr\_cluster\_id | Identifier for the AWS EMR cluster created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Reference documents:
* AWS EMR HBase: https://aws.amazon.com/emr/features/hbase/
* AWS EMR Cluster Terraform Docs: https://www.terraform.io/docs/providers/aws/r/emr_cluster.html
* Terraform module structure: https://www.terraform.io/docs/modules/index.html#standard-module-structure

