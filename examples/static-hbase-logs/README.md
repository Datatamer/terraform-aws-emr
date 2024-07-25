This example depends on an existing VPC and subnet with configurations that meets [EMR cluster requirements](https://aws.amazon.com/blogs/big-data/launching-and-running-an-amazon-emr-cluster-inside-a-vpc/).

# Cloudwatch log collection example for an EMR Static HBase cluster

The following example will deploy the necessary resources on every instance that belongs to an EMR Cluster in order to:
- Download the Cloudwatch agent.
- Install the Cloudwatch agent.
- Create and mount the configuration file.
- Enable the Cloudwatch agent.

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
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.5.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws-emr-sg-core"></a> [aws-emr-sg-core](#module\_aws-emr-sg-core) | git::git@github.com:Datatamer/terraform-aws-security-groups.git | 1.0.1 |
| <a name="module_aws-emr-sg-master"></a> [aws-emr-sg-master](#module\_aws-emr-sg-master) | git::git@github.com:Datatamer/terraform-aws-security-groups.git | 1.0.1 |
| <a name="module_aws-emr-sg-service-access"></a> [aws-emr-sg-service-access](#module\_aws-emr-sg-service-access) | git::git@github.com:Datatamer/terraform-aws-security-groups.git | 1.0.1 |
| <a name="module_emr-hbase"></a> [emr-hbase](#module\_emr-hbase) | ../.. | n/a |
| <a name="module_emr-logs-bucket"></a> [emr-logs-bucket](#module\_emr-logs-bucket) | git::git@github.com:Datatamer/terraform-aws-s3.git | 1.3.2 |
| <a name="module_emr-rootdir-bucket"></a> [emr-rootdir-bucket](#module\_emr-rootdir-bucket) | git::git@github.com:Datatamer/terraform-aws-s3.git | 1.3.2 |
| <a name="module_emr_key_pair"></a> [emr\_key\_pair](#module\_emr\_key\_pair) | terraform-aws-modules/key-pair/aws | 1.0.0 |
| <a name="module_sg-ports"></a> [sg-ports](#module\_sg-ports) | ../../modules/aws-emr-ports | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.tamr_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_s3_bucket_object.sample_bootstrap_script](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [local_file.cloudwatch-install](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [tls_private_key.emr_private_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name_for_logs"></a> [bucket\_name\_for\_logs](#input\_bucket\_name\_for\_logs) | S3 bucket name for cluster logs. | `string` | n/a | yes |
| <a name="input_bucket_name_for_root_directory"></a> [bucket\_name\_for\_root\_directory](#input\_bucket\_name\_for\_root\_directory) | S3 bucket name for storing root directory | `string` | n/a | yes |
| <a name="input_compute_subnet_id"></a> [compute\_subnet\_id](#input\_compute\_subnet\_id) | ID of the subnet where the EMR cluster will be created. If `abac_valid_tags` key values are set, this subnet is required to have a valid key value tag as well. | `string` | n/a | yes |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | CIDR blocks to attach to security groups for ingress | `list(string)` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | A string to prepend to names of the resources in the cluster | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID of the network. | `string` | n/a | yes |
| <a name="input_vpce_logs_endpoint_dnsname"></a> [vpce\_logs\_endpoint\_dnsname](#input\_vpce\_logs\_endpoint\_dnsname) | Cloudwatch VPC Interface Endpoint DNS name which will be provided to the script to install and configure the Cloudwatch agent. | `string` | n/a | yes |
| <a name="input_abac_valid_tags"></a> [abac\_valid\_tags](#input\_abac\_valid\_tags) | Valid tags for maintaining resources when using ABAC IAM Policies with Tag Conditions. Make sure `tags` contain a key value specified here. | `map(list(string))` | `{}` | no |
| <a name="input_egress_cidr_blocks"></a> [egress\_cidr\_blocks](#input\_egress\_cidr\_blocks) | CIDR blocks to attach to security groups for egress | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources created by this example. | `map(string)` | <pre>{<br>  "Author": "Tamr",<br>  "Environment": "Example"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster"></a> [cluster](#output\_cluster) | n/a |
| <a name="output_ec2-key"></a> [ec2-key](#output\_ec2-key) | n/a |
| <a name="output_logs-bucket"></a> [logs-bucket](#output\_logs-bucket) | n/a |
| <a name="output_private-key"></a> [private-key](#output\_private-key) | n/a |
| <a name="output_rootdir-bucket"></a> [rootdir-bucket](#output\_rootdir-bucket) | n/a |
<!-- END_TF_DOCS -->
