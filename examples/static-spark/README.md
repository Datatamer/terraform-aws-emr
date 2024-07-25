This example depends on an existing VPC and subnet with configurations that meets [EMR cluster requirements](https://aws.amazon.com/blogs/big-data/launching-and-running-an-amazon-emr-cluster-inside-a-vpc/).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.5.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws-emr-sg-core"></a> [aws-emr-sg-core](#module\_aws-emr-sg-core) | git::git@github.com:Datatamer/terraform-aws-security-groups.git | 1.0.1 |
| <a name="module_aws-emr-sg-master"></a> [aws-emr-sg-master](#module\_aws-emr-sg-master) | git::git@github.com:Datatamer/terraform-aws-security-groups.git | 1.0.1 |
| <a name="module_aws-emr-sg-service-access"></a> [aws-emr-sg-service-access](#module\_aws-emr-sg-service-access) | git::git@github.com:Datatamer/terraform-aws-security-groups.git | 1.0.1 |
| <a name="module_emr-logs-bucket"></a> [emr-logs-bucket](#module\_emr-logs-bucket) | git::git@github.com:Datatamer/terraform-aws-s3.git | 1.3.2 |
| <a name="module_emr-rootdir-bucket"></a> [emr-rootdir-bucket](#module\_emr-rootdir-bucket) | git::git@github.com:Datatamer/terraform-aws-s3.git | 1.3.2 |
| <a name="module_emr-spark"></a> [emr-spark](#module\_emr-spark) | ../.. | n/a |
| <a name="module_emr_key_pair"></a> [emr\_key\_pair](#module\_emr\_key\_pair) | terraform-aws-modules/key-pair/aws | 1.0.0 |
| <a name="module_sg-ports"></a> [sg-ports](#module\_sg-ports) | ../../modules/aws-emr-ports | n/a |

## Resources

| Name | Type |
|------|------|
| [tls_private_key.emr_private_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name_for_logs"></a> [bucket\_name\_for\_logs](#input\_bucket\_name\_for\_logs) | S3 bucket name for cluster logs. | `string` | n/a | yes |
| <a name="input_bucket_name_for_root_directory"></a> [bucket\_name\_for\_root\_directory](#input\_bucket\_name\_for\_root\_directory) | S3 bucket name for storing root directory. | `string` | n/a | yes |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | CIDR blocks to attach to security groups for ingress | `list(string)` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | A string to prepend to names of the resources in the cluster | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet where the EMR cluster will be created | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID of the network | `string` | n/a | yes |
| <a name="input_abac_valid_tags"></a> [abac\_valid\_tags](#input\_abac\_valid\_tags) | Valid tags for maintaining resources when using ABAC IAM Policies with Tag Conditions. Make sure `tags` contain a key value specified here. | `map(list(string))` | `{}` | no |
| <a name="input_egress_cidr_blocks"></a> [egress\_cidr\_blocks](#input\_egress\_cidr\_blocks) | CIDR blocks to attach to security groups for egress | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources created by this example. | `map(string)` | <pre>{<br>  "Author": "Tamr",<br>  "Environment": "Example"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster"></a> [cluster](#output\_cluster) | n/a |
| <a name="output_logs-bucket"></a> [logs-bucket](#output\_logs-bucket) | n/a |
| <a name="output_rootdir-bucket"></a> [rootdir-bucket](#output\_rootdir-bucket) | n/a |
<!-- END_TF_DOCS -->
