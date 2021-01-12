# TAMR AWS EMR module

## v0.12.1 - January 12th 2021
* Adds optional input `bootstrap_actions` to run ordered list of actions on cluster nodes before Hadoop starts.
* Adds example usage of `bootstrap_actions` in examples/static-hbase

## v0.12.0 - January 8th 2021
* Exposes variable json_configuration_bucket_key to make the path to the EMR configuration file
 settable.
* Adds new variable utility_script_bucket_key to make path of the utility script that uploads
 emr configuration files to s3 settable.

## v0.11.1 - December 15th 2020
* Updates the config.json to match state in AWS
* Logs path in examples updated to match state in AWS

## v0.11.0 - November 24th 2020
* Removes support for EMR security configuration due to issues with resource deletion

## v0.10.7 - November 17th 2020
* Fixes for issues with the outputs.tf when a resource does not exist
* Upgrades the s3 module in the examples

## v0.10.6 - October 22nd 2020
* Adds the following module outputs - `hbase_config_path`, `release_label`, `core_group_instance_count`, `core_ebs_size`, `core_ebs_type`, `core_instance_type`, `master_instance_type`, `master_ebs_volumes_count`, `master_ebs_size`, `master_ebs_type`, `log_uri`, `subnet_id`
* Adds input `bucket_path_to_logs`
* Fixes bug that causes EMR cluster creation to occur prematurely before cluster configuration module has posted to S3

## v0.10.5 - October 20th 2020
* Adds submodule for EMR cluster creation
* Adds submodule for cluster configuration resources
  * Updates ephemeral-spark example to directly invoke submodules

## v0.10.4 - October 19th 2020
* Adds `tamr_emr_cluster_name` output

## v0.10.3 - October 13th 2020
* Fixes a bug where hbase configuration did not upload to s3

## v0.10.2 - October 13th 2020
* Adds the MapReduce JobHistory server webapp port to the security group rules

## v0.10.1 - October 12th 2020
* Adds http port to the security group for the master and config enable_http_port to toggle

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
