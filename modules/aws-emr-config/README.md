# Terraform AWS EMR Configuration Terraform Module
This terraform module creates the configuration resources for a EMR cluster.

# Examples
## Minimal
This example directly invokes this submodule.
- [Ephemeral Spark Example](https://github.com/Datatamer/terraform-aws-emr/tree/master/examples/ephemeral-spark)

# Resources Created
This module creates:
* A bucket object with the cluster's JSON configuration in the root directory S3 bucket

If you are creating a static cluster, this module also creates:
* A bucket object with a bash script to upload HBase/Hadoop configuration to S3
* An EMR security configuration

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 2.45.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.45.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_name\_for\_root\_directory | S3 bucket name for storing root directory | `string` | n/a | yes |
| emr\_config\_file\_path | Path to the EMR JSON configuration file. Please include the file name as well. | `string` | n/a | yes |
| cluster\_name | Name for the EMR cluster to be created | `string` | `"TAMR-EMR-Cluster"` | no |
| create\_static\_cluster | True if the module should create a static cluster. False if the module should create supporting infrastructure but not the cluster itself. | `bool` | `true` | no |
| emrfs\_metadata\_read\_capacity | Read capacity units of the DynamoDB table used for EMRFS metadata | `number` | `600` | no |
| emrfs\_metadata\_table\_name | Table name of EMRFS metadata table in DynamoDB | `string` | `"EmrFSMetadata"` | no |
| emrfs\_metadata\_write\_capacity | Write capacity units of the DynamoDB table used for EMRFS metadata | `number` | `300` | no |
| hadoop\_config\_path | Path in root directory bucket to upload Hadoop config to | `string` | `"config/hadoop/conf/"` | no |
| hbase\_config\_path | Path in root directory bucket to upload HBase config to | `string` | `"config/hbase/conf.dist/"` | no |
| json\_configuration\_bucket\_key | Key (i.e. path) of JSON configuration bucket object in the root directory bucket | `string` | `"config.json"` | no |
| utility\_script\_bucket\_key | Key (i.e. path) to upload the utility script to | `string` | `"util/upload_hbase_config.sh"` | no |

## Outputs

| Name | Description |
|------|-------------|
| emr\_config\_file\_path | Path to the EMR JSON configuration file that was uploaded to S3. |
| emrfs\_dynamodb\_table\_name | Name for the emrfs dynamodb table |
| hbase\_config\_path | Path in the root directory bucket that HBase config was uploaded to |
| json\_config\_s3\_key | The name of the json configuration object in the bucket. |
| upload\_config\_script\_s3\_key | The name of the upload config script object in the bucket. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [AWS EMR Security Configuration](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-create-security-configuration.html)

# License
Apache 2 Licensed. See LICENSE for full details.
