This example depends on an existing VPC and subnet with configurations that meets [EMR cluster requirements](https://aws.amazon.com/blogs/big-data/launching-and-running-an-amazon-emr-cluster-inside-a-vpc/).

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
| abac\_valid\_tags | A map of tags that will be inserted inside IAM Policies conditions for restricting EMR Service Role access | `map(string)` | <pre>{<br>  "tamr.com/role": "emr"<br>}</pre> | no |
| tags | A map of tags to add to all resources created by this example. | `map(string)` | <pre>{<br>  "Author": "Tamr",<br>  "Environment": "Example"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| config | n/a |
| iam | n/a |
| logs-bucket | n/a |
| rootdir-bucket | n/a |
| sgs | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
