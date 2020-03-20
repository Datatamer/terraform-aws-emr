# Tamr AWS EMR HBase Terraform Module

## Description
This terraform module creates the AWS S3 buckets required for EMR Hbase logs and root directory

## Variables
* `bucket_name_for_logs`: Name of the S3 bucket to save EMR Hbase logs
* `bucket_name_for_hbase_root_dir`: Name of the S3 bucket for EMR Hbase root directory
* `additional_tags`: Additional Tags to be attached

## AWS Resources created
This terraform module will create 2 S3 buckets, one for EMR Hbase logs and one for EMR Hbase root directory


## Usage Example
See the `examples` directory for examples.
