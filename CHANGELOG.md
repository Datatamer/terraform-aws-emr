# TAMR AWS EMR module

## v0.10.0 - October 7th 2020
* Refactor module to support common patterns of use
  * Supports creation of infrastructure for static HBase cluster
  * Supports creation of infrastruction for static Spark cluster
  * Supports creation of infrastructure for ephemeral Spark cluster
* Adds example for each pattern of use

## v0.9.0 - October 6th 2020
* Removes logs and root directory S3 bucket creation in root module.
* Deprecates S3 submodule.
* Adds s3_policy_arns input variable to pass bucket access policies to EMR EC2 instance profile.
* Modifies minimal example to rely on the [terraform-aws-s3 module](https://github.com/Datatamer/terraform-aws-s3) for the creation of bucket(s).
* Removes aws_account_id variable.
* Adds EMR security configuration.

## v0.8.1 - September 11th 2020
* Add AES256 server side encryption on aws_s3_bucket_object resources

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
