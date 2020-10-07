<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| applications | List of applications to run on EMR | `list(string)` | n/a | yes |
| bucket\_name\_for\_logs | S3 bucket name for cluster logs. | `string` | n/a | yes |
| bucket\_name\_for\_root\_directory | S3 bucket name for storing root directory. | `string` | n/a | yes |
| cluster\_name | Name for the EMR cluster to be created | `string` | n/a | yes |
| emr\_config\_file\_path | Path to the EMR JSON configuration file. Please include the file name as well. | `string` | n/a | yes |
| emrfs\_metadata\_table\_name | Name of the Dynamodb table (already created or to be used for EMR consistent view) | `string` | n/a | yes |
| key\_pair\_name | Name of the Key Pair that will be attached to the EC2 instances | `string` | n/a | yes |
| subnet\_id | ID of the subnet where the EMR cluster will be created | `string` | n/a | yes |
| vpc\_id | VPC ID of the network | `string` | n/a | yes |
| additional\_tags | Additional tags to be attached to the resources created | `map(string)` | `{}` | no |
| aws\_region\_of\_dynamodb\_table | AWS Region for the EMRFS Metadata Dynamodb table | `string` | `"us-east-1"` | no |
| create\_static\_cluster | True if the module should create a static cluster. False if the module should create supporting infrastructure but not the cluster itself. | `bool` | `true` | no |
| emr\_ec2\_instance\_profile\_name | Name for the new instance profile for the EMR EC2 instances | `string` | `"tamr_emr_ec2_instance_profile"` | no |
| emr\_ec2\_role\_name | Name for the new iam role for the EMR EC2 instances | `string` | `"tamr_emr_ec2_role"` | no |
| emr\_service\_role\_name | Name for the new iam service role for the EMR cluster | `string` | `"tamr_emr_service_role"` | no |
| tamr\_cidrs | List of CIDRs for Tamr | `list(string)` | `[]` | no |
| tamr\_sgs | Security Group for the Tamr Instance | `list(string)` | `[]` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
