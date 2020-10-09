This example depends on an existing VPC and subnet with configurations that meet [EMR cluster requirements](https://aws.amazon.com/blogs/big-data/launching-and-running-an-amazon-emr-cluster-inside-a-vpc/).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_name\_for\_logs | S3 bucket name for cluster logs. | `string` | n/a | yes |
| bucket\_name\_for\_root\_directory | S3 bucket name for storing root directory. | `string` | n/a | yes |
| vpc\_id | VPC ID of the network | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
