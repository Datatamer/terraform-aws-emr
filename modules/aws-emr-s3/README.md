# Tamr AWS EMR HBase Terraform Module
This terraform module creates the AWS S3 buckets required for EMR Hbase logs and root directory

# Example
```
module "emr-hbase-s3" {
  source = "git::git@github.com:Datatamer/terraform-emr-hbase.git//modules/aws-emr-s3?ref=0.1.0"
  bucket_name_for_hbase_root_dir = "examplebucketname1"
  bucket_name_for_logs = "examplebucketname2"
}
```

# Variables
## Inputs:
* `bucket_name_for_logs` (optional): Name of the S3 bucket to save EMR Hbase logs
* `bucket_name_for_hbase_root_dir` (optional): Name of the S3 bucket for EMR Hbase root directory
* `additional_tags` (optional): Additional Tags to be attached

## Outputs:
* `s3_bucket_name_for_logs`: Name of the S3 bucket used for EMR Hbase logs
* `s3_bucket_name_for_hbase_rootdir`: Name of the S3 bucket used for EMR Hbase root directory

# AWS Resources created
This terraform module will create 2 S3 buckets, one for EMR Hbase logs and one for EMR Hbase root directory
