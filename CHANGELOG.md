# TAMR AWS EMR Hbase module

## v0.9.0 -
* Adds `existing_hbase_logs_bucket_name` and `existing_hbase_root_dir_bucket_name` to provide option to pass in exsting logs and/or root directory S3 bucket.

## v0.8.0 - September 8th 2020
* Uploads HBase configuration to S3.
* Enables SSE for EMRFS data in S3.

## v0.7.0 - September 8th 2020
* Enforces SSE-S3 encryption on S3 buckets.

## v0.6.0 - July 29th 2020
* Adds support for EMR 5.30.0

## v0.5.0 - June 15th 2020
* Moves the EMR cluster creation to the root of the module
* Adds EBS configuration variables

## v0.4.0 - June 8th 2020
* Adds more hbase configuration
* Updates READMEs to use generated documentation
* More consistent formatting applied
* Makes the list of applications configurable

## v0.3.0 - May 19th 2020
* Added creation of Dynamodb table for EMRFS for better control of the resources through terraform module. Previously it was controlled by EMR.

## v0.2.0 - May 6th 2020
* Force destroy set to true for S3 buckets. Buckets will be deleted even when they still have objects stored in them.
    * The new policy can be applied as an in-place change to existing buckets.

## v0.1.0 - March 31st 2020
### Added
* Root module for EMR Hbase
* Sub modules:
    * S3 module
    * Security Groups module
    * IAM module
    * EMR Hbase cluster module
