# TAMR AWS EMR Hbase root module

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
