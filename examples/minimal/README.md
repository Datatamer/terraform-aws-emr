<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_account\_id | Account ID of the AWS account | `string` | n/a | yes |
| bucket\_name\_for\_hbase\_root\_dir | S3 bucket name for EMR Hbase root directory | `string` | n/a | yes |
| bucket\_name\_for\_logs | S3 bucket name for EMR Hbase logs | `string` | n/a | yes |
| cluster\_name | Name for the EMR Hbase cluster to be created | `string` | n/a | yes |
| emr\_hbase\_config\_file\_path | Path to the EMR Hbase config file. Please include the file name as well. | `string` | n/a | yes |
| emrfs\_metadata\_table\_name | Name of the Dynamodb table (already created or to be used for EMR consistent view) | `string` | n/a | yes |
| key\_pair\_name | Name of the Key Pair that will be attached to the EC2 instances | `string` | n/a | yes |
| subnet\_id | ID of the subnet where the emr cluster will be created | `string` | n/a | yes |
| vpc\_id | VPC id of the network | `string` | n/a | yes |
| additional\_tags | Additional tags to be attached to the resources created | `map(string)` | `{}` | no |
| aws\_region\_of\_dynamodb\_table | AWS Region for the EMRFS Metadata Dynamodb table | `string` | `"us-east-1"` | no |
| emr\_ec2\_instance\_profile\_name | Name for the new instance profile for the EMR Hbase EC2 instances | `string` | `"tamr_emr_ec2_instance_profile"` | no |
| emr\_ec2\_role\_name | Name for the new iam role for the EMR Hbase EC2 instances | `string` | `"tamr_emr_ec2_role"` | no |
| emr\_service\_role\_name | Name for the new iam service role for the EMR Hbase cluster | `string` | `"tamr_emr_service_role"` | no |
| tamr\_cidrs | List of CIDRs for Tamr | `list(string)` | `[]` | no |
| tamr\_sgs | Security Group for the Tamr Instance | `list(string)` | `[]` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
