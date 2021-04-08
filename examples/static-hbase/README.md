This example depends on an existing VPC and subnet with configurations that meet [EMR cluster requirements](https://aws.amazon.com/blogs/big-data/launching-and-running-an-amazon-emr-cluster-inside-a-vpc/).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| aws | 3.27.0 |
| template | ~> 2.1.2 |

## Providers

| Name | Version |
|------|---------|
| aws | 3.27.0 |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_name\_for\_logs | S3 bucket name for cluster logs. | `string` | n/a | yes |
| bucket\_name\_for\_root\_directory | S3 bucket name for storing root directory | `string` | n/a | yes |
| subnet\_id | ID of the subnet where the EMR cluster will be created | `string` | n/a | yes |
| vpc\_id | VPC ID of the network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster | n/a |
| ec2-key | n/a |
| logs-bucket | n/a |
| private-key | n/a |
| rootdir-bucket | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
