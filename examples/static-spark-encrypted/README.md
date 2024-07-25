This example depends on an existing VPC and subnet with configurations that meets [EMR cluster requirements](https://aws.amazon.com/blogs/big-data/launching-and-running-an-amazon-emr-cluster-inside-a-vpc/).

# At rest and In-transit encryption example for an EMR Static Spark cluster

This example will enable `at rest`encryption for EBS drives and `in-transit`encryption for the EMR cluster by default.

## Pre-requisites:

Enabling encryption for EMR requires PEM files located in S3, so the EMR cluster's instance profile will need to allow read operations on the bucket that hosts said files.

## How to create a PEM file?

The following example demonstrates how to use OpenSSL to generate a self-signed X.509 certificate with a 1024-bit RSA private key. The key allows access to the issuer's Amazon EMR cluster instances in the us-east-2 (Ohio) region as specified by the *.us-east-2.compute.internal domain name as the common name.

Other optional subject items, such as country (C), state (S), and Locale (L), are specified. Because a self-signed certificate is generated, the second command in the example copies the certificateChain.pem file to the trustedCertificates.pem file. The third command uses zip to create the my-certs.zip file that contains the certificates.

The following steps can be run in order to create a PEM zip file for in-transit encryption and then upload it to a bucket:

- $ openssl req -x509 -newkey rsa:1024 -keyout privateKey.pem -out certificateChain.pem -days 365 -nodes -subj '/C=US/ST=Ohio/L=Columbus/O=MyOrg/OU=MyDept/CN=*.us-east-2.compute.internal'
- $ cp certificateChain.pem trustedCertificates.pem
- $ zip -r -X my-certs.zip certificateChain.pem privateKey.pem trustedCertificates.pem
- Upload the zip PEM file to a bucket that you own.
- Ensure that the bucket can be accessed by EMR.
- Provide the S3 PEM zip file object URL path to `s3_pem_file_location` variable.

## IMPORTANT
This example is a proof-of-concept demonstration only. Using self-signed certificates is not recommended and presents a potential security risk. For production systems, use a trusted certification authority (CA) to issue certificates.

## What else this example do?

The example will also deploy the necessary resources on every instance that belongs to an EMR Cluster in order to:

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
| <a name="module_emr-logs-bucket"></a> [emr-logs-bucket](#module\_emr-logs-bucket) | git::git@github.com:Datatamer/terraform-aws-s3.git | 1.3.2 |
| <a name="module_emr-rootdir-bucket"></a> [emr-rootdir-bucket](#module\_emr-rootdir-bucket) | git::git@github.com:Datatamer/terraform-aws-s3.git | 1.3.2 |
| <a name="module_emr-spark"></a> [emr-spark](#module\_emr-spark) | ../.. | n/a |
| <a name="module_emr_key_pair"></a> [emr\_key\_pair](#module\_emr\_key\_pair) | terraform-aws-modules/key-pair/aws | 1.0.0 |
| <a name="module_sg-ports"></a> [sg-ports](#module\_sg-ports) | ../../modules/aws-emr-ports | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.tamr_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_emr_security_configuration.secconfig](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/emr_security_configuration) | resource |
| [aws_iam_policy.emr_service_policy_for_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.emr_service_role_policy_for_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.kms_encryption_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.kms_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket_object.sample_bootstrap_script](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [local_file.cloudwatch-install](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [tls_private_key.emr_private_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.emr_service_policy_for_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name_for_logs"></a> [bucket\_name\_for\_logs](#input\_bucket\_name\_for\_logs) | S3 bucket name for cluster logs. | `string` | n/a | yes |
| <a name="input_bucket_name_for_root_directory"></a> [bucket\_name\_for\_root\_directory](#input\_bucket\_name\_for\_root\_directory) | S3 bucket name for storing root directory. | `string` | n/a | yes |
| <a name="input_compute_subnet_id"></a> [compute\_subnet\_id](#input\_compute\_subnet\_id) | ID of the subnet where the EMR cluster will be created. If `abac_valid_tags` key values are set, this subnet is required to have a valid key value tag as well. | `string` | n/a | yes |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | CIDR blocks to attach to security groups for ingress | `list(string)` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | A string to prepend to names of the resources in the cluster | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID of the network | `string` | n/a | yes |
| <a name="input_vpce_logs_endpoint_dnsname"></a> [vpce\_logs\_endpoint\_dnsname](#input\_vpce\_logs\_endpoint\_dnsname) | DNS name of the Cloudwatch VPC Interface Endpoint which will be provided to the script to install and configure the Cloudwatch agent. | `string` | n/a | yes |
| <a name="input_abac_valid_tags"></a> [abac\_valid\_tags](#input\_abac\_valid\_tags) | Valid tags for maintaining resources when using ABAC IAM Policies with Tag Conditions. Make sure `tags` contain a key value specified here. | `map(list(string))` | `{}` | no |
| <a name="input_egress_cidr_blocks"></a> [egress\_cidr\_blocks](#input\_egress\_cidr\_blocks) | CIDR blocks to attach to security groups for egress | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_enable_at_rest_encryption"></a> [enable\_at\_rest\_encryption](#input\_enable\_at\_rest\_encryption) | Specify true to enable at-rest encryption and false to disable it. | `bool` | `true` | no |
| <a name="input_enable_ebs_encryption"></a> [enable\_ebs\_encryption](#input\_enable\_ebs\_encryption) | Specify true to enable EBS encryption. EBS encryption encrypts the EBS root device volume and attached storage volumes. | `bool` | `true` | no |
| <a name="input_enable_in_transit_encryption"></a> [enable\_in\_transit\_encryption](#input\_enable\_in\_transit\_encryption) | Specify true to enable in-transit encryption and false to disable it. | `bool` | `true` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Customer Managed key ARN used to encrypt the EBS drives. | `string` | `""` | no |
| <a name="input_s3_pem_file_location"></a> [s3\_pem\_file\_location](#input\_s3\_pem\_file\_location) | Specify the S3 path where the PEM zip file is located. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources created by this example. | `map(string)` | <pre>{<br>  "Author": "Tamr",<br>  "Environment": "Example"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster"></a> [cluster](#output\_cluster) | EMR Cluster output information. |
| <a name="output_logs-bucket"></a> [logs-bucket](#output\_logs-bucket) | S3 bucket where EMR cluster logs objects are stored. |
| <a name="output_rootdir-bucket"></a> [rootdir-bucket](#output\_rootdir-bucket) | S3 bucket where EMR cluster root objects are stored. |
<!-- END_TF_DOCS -->
