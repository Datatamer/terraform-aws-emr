<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.5.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_emr-logs-bucket"></a> [emr-logs-bucket](#module\_emr-logs-bucket) | git::git@github.com:Datatamer/terraform-aws-s3.git | 1.3.2 |
| <a name="module_emr-rootdir-bucket"></a> [emr-rootdir-bucket](#module\_emr-rootdir-bucket) | git::git@github.com:Datatamer/terraform-aws-s3.git | 1.3.2 |
| <a name="module_ephemeral-spark-config"></a> [ephemeral-spark-config](#module\_ephemeral-spark-config) | ../../modules/aws-emr-config | n/a |
| <a name="module_ephemeral-spark-iam"></a> [ephemeral-spark-iam](#module\_ephemeral-spark-iam) | ../../modules/aws-emr-iam | n/a |
| <a name="module_ephemeral-spark-sgs"></a> [ephemeral-spark-sgs](#module\_ephemeral-spark-sgs) | ../../modules/aws-emr-sgs | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name_for_logs"></a> [bucket\_name\_for\_logs](#input\_bucket\_name\_for\_logs) | S3 bucket name for cluster logs. | `string` | n/a | yes |
| <a name="input_bucket_name_for_root_directory"></a> [bucket\_name\_for\_root\_directory](#input\_bucket\_name\_for\_root\_directory) | S3 bucket name for storing root directory. | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | A string to prepend to names of the resources in the cluster | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID of the network | `string` | n/a | yes |
| <a name="input_abac_valid_tags"></a> [abac\_valid\_tags](#input\_abac\_valid\_tags) | A map of tags that will be inserted inside IAM Policies conditions for restricting EMR Service Role access | `map(list(string))` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources created by this example. | `map(string)` | <pre>{<br>  "Author": "Tamr",<br>  "Environment": "Example"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config"></a> [config](#output\_config) | n/a |
| <a name="output_iam"></a> [iam](#output\_iam) | n/a |
| <a name="output_logs-bucket"></a> [logs-bucket](#output\_logs-bucket) | n/a |
| <a name="output_rootdir-bucket"></a> [rootdir-bucket](#output\_rootdir-bucket) | n/a |
| <a name="output_sgs"></a> [sgs](#output\_sgs) | n/a |
<!-- END_TF_DOCS -->