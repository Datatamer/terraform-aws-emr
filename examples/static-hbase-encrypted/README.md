This example depends on an existing VPC and subnet with configurations that meets [EMR cluster requirements](https://aws.amazon.com/blogs/big-data/launching-and-running-an-amazon-emr-cluster-inside-a-vpc/).

# EMR Static HBase cluster with EBS encryption example

The following example will deploy the necessary resources on every instance that belongs to an EMR Cluster in order to:
- Configure a KMS VPC Endpoint.
- Create a KMS if not provided as a variable.
- Grant needed permissions to manage the KMS key.
- Enable the "At rest" encryption for EBS.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| local | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_subnet\_id | ID of the subnet where the Tamr VM and the Cloudwatch VPC Endpoint will be created. If `abac_valid_tags` key values are set, this subnet is required to have a valid key value tag as well. | `string` | n/a | yes |
| bucket\_name\_for\_logs | S3 bucket name for cluster logs. | `string` | n/a | yes |
| bucket\_name\_for\_root\_directory | S3 bucket name for storing root directory | `string` | n/a | yes |
| compute\_subnet\_cidr\_block | The EMR Cluster subnet CIDR range | `string` | n/a | yes |
| compute\_subnet\_id | ID of the subnet where the EMR cluster will be created. If `abac_valid_tags` key values are set, this subnet is required to have a valid key value tag as well. | `string` | n/a | yes |
| ingress\_cidr\_blocks | CIDR blocks to attach to security groups for ingress | `list(string)` | n/a | yes |
| name\_prefix | A string to prepend to names of the resources in the cluster | `string` | n/a | yes |
| vpc\_id | VPC ID of the network. | `string` | n/a | yes |
| vpce\_logs\_endpoint\_dnsname | Cloudwatch VPC Interface Endpoint DNS name which will be provided to the script to install and configure the Cloudwatch agent. | `string` | n/a | yes |
| abac\_valid\_tags | Valid tags for maintaining resources when using ABAC IAM Policies with Tag Conditions. Make sure `tags` contain a key value specified here. | `map(list(string))` | `{}` | no |
| egress\_cidr\_blocks | CIDR blocks to attach to security groups for egress | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| enable\_at\_rest\_encryption | Specify true to enable at-rest encryption and false to disable it. | `bool` | `false` | no |
| enable\_ebs\_encryption | Specify true to enable EBS encryption. EBS encryption encrypts the EBS root device volume and attached storage volumes. | `bool` | `false` | no |
| enable\_in\_transit\_encryption | Specify true to enable in-transit encryption and false to disable it. | `bool` | `false` | no |
| kms\_key\_arn | Customer Managed key ARN used to encrypt the EBS drives. | `string` | `""` | no |
| tags | A map of tags to add to all resources created by this example. | `map(string)` | <pre>{<br>  "Author": "Tamr",<br>  "Environment": "Example"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster | n/a |
| ec2-key | n/a |
| kms-key | n/a |
| logs-bucket | n/a |
| private-key | n/a |
| rootdir-bucket | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
