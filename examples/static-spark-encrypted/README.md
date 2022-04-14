This example depends on an existing VPC and subnet with configurations that meets [EMR cluster requirements](https://aws.amazon.com/blogs/big-data/launching-and-running-an-amazon-emr-cluster-inside-a-vpc/).

# Cloudwatch log collection example for an EMR Static Spark cluster

## Pre-requisites:

Enabling encryption for EMR requires PEM files located in S3, so the EMR cluster's instance profile will need to allow read operations on the bucket that hosts said files.


## How to create a PEM file?

The following example demonstrates how to use OpenSSL to generate a self-signed X.509 certificate with a 1024-bit RSA private key. The key allows access to the issuer's Amazon EMR cluster instances in the us-east-2 (Ohio) region as specified by the *.us-east-2.compute.internal domain name as the common name.

Other optional subject items, such as country (C), state (S), and Locale (L), are specified. Because a self-signed certificate is generated, the second command in the example copies the certificateChain.pem file to the trustedCertificates.pem file. The third command uses zip to create the my-certs.zip file that contains the certificates.

- 1- $ openssl req -x509 -newkey rsa:1024 -keyout privateKey.pem -out certificateChain.pem -days 365 -nodes -subj '/C=US/ST=Ohio/L=Columbus/O=MyOrg/OU=MyDept/CN=*.us-east-2.compute.internal'
- 2- $ cp certificateChain.pem trustedCertificates.pem
- 3- $ zip -r -X my-certs.zip certificateChain.pem privateKey.pem trustedCertificates.pem
- 4- Upload the zip PEM file to a bucket that you own.
- 5- Ensure that the bucket can be accessed by EMR.
- 6- Provide the S3 PEM zip file object URL path to `s3_pem_file_location` variable.

## IMPORTANT
This example is a proof-of-concept demonstration only. Using self-signed certificates is not recommended and presents a potential security risk. For production systems, use a trusted certification authority (CA) to issue certificates.

## What else this example do?

The example will also deploy the necessary resources on every instance that belongs to an EMR Cluster in order to:

- Download the Cloudwatch agent.
- Install the Cloudwatch agent.
- Create and mount the configuration file.
- Enable the Cloudwatch agent.

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
| bucket\_name\_for\_root\_directory | S3 bucket name for storing root directory. | `string` | n/a | yes |
| compute\_subnet\_cidr\_block | The EMR Cluster subnet CIDR range | `string` | n/a | yes |
| compute\_subnet\_id | ID of the subnet where the EMR cluster will be created. If `abac_valid_tags` key values are set, this subnet is required to have a valid key value tag as well. | `string` | n/a | yes |
| ingress\_cidr\_blocks | CIDR blocks to attach to security groups for ingress | `list(string)` | n/a | yes |
| name\_prefix | A string to prepend to names of the resources in the cluster | `string` | n/a | yes |
| vpc\_id | VPC ID of the network | `string` | n/a | yes |
| vpce\_logs\_endpoint\_dnsname | DNS name of the Cloudwatch VPC Interface Endpoint which will be provided to the script to install and configure the Cloudwatch agent. | `string` | n/a | yes |
| abac\_valid\_tags | Valid tags for maintaining resources when using ABAC IAM Policies with Tag Conditions. Make sure `tags` contain a key value specified here. | `map(list(string))` | `{}` | no |
| arn\_partition | The partition in which the resource is located. A partition is a group of AWS Regions.<br>  Each AWS account is scoped to one partition.<br>  The following are the supported partitions:<br>    aws -AWS Regions<br>    aws-cn - China Regions<br>    aws-us-gov - AWS GovCloud (US) Regions | `string` | `"aws"` | no |
| egress\_cidr\_blocks | CIDR blocks to attach to security groups for egress | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| enable\_at\_rest\_encryption | Specify true to enable at-rest encryption and false to disable it. | `bool` | `true` | no |
| enable\_ebs\_encryption | Specify true to enable EBS encryption. EBS encryption encrypts the EBS root device volume and attached storage volumes. | `bool` | `true` | no |
| enable\_in\_transit\_encryption | Specify true to enable in-transit encryption and false to disable it. | `bool` | `true` | no |
| kms\_key\_arn | Customer Managed key ARN used to encrypt the EBS drives. | `string` | `""` | no |
| s3\_pem\_file\_location | Specify the S3 path where the PEM zip file is located. | `string` | `"s3://aws-logs-327120324092-us-east-2/my-certs.zip"` | no |
| tags | A map of tags to add to all resources created by this example. | `map(string)` | <pre>{<br>  "Author": "Tamr",<br>  "Environment": "Example"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster | EMR Cluster output information. |
| logs-bucket | S3 bucket where EMR cluster logs objects are stored. |
| rootdir-bucket | S3 bucket where EMR cluster root objects are stored. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
