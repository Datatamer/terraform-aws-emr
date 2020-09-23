# Tamr AWS EMR S3 Terraform Module
This terraform module creates the AWS S3 buckets required for EMR Hbase logs and root directory

# Example
```
module "emr-hbase-s3" {
  source                         = "git::git@github.com:Datatamer/terraform-aws-emr.git//modules/aws-emr-s3?ref=0.8.1"
  bucket_name_for_hbase_root_dir = "examplebucketname1"
  bucket_name_for_logs           = "examplebucketname2"
}
```

# Resources created
This module creates:
* 2 S3 buckets, one for EMR Hbase logs and one for EMR Hbase root directory

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
| additional\_tags | Additional tags to be attached to the resources created | `map(string)` | `{}` | no |
| bucket\_name\_for\_hbase\_root\_dir | S3 bucket name for EMR Hbase root directory | `string` | `"tamr-emr-hbase-root-dir"` | no |
| bucket\_name\_for\_logs | S3 bucket name for EMR Hbase logs | `string` | `"tamr-emr-hbase-logs"` | no |

## Outputs

| Name | Description |
|------|-------------|
| s3\_bucket\_name\_for\_hbase\_rootdir | S3 bucket name for EMR Hbase root directory |
| s3\_bucket\_name\_for\_logs | S3 bucket name for EMR logs |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
