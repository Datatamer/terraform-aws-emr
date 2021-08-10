# TAMR AWS EMR module

## v6.1.0 - August 10th, 2021
* Adds new variable `abac_valid_tags` to be used in IAM Policies conditions for creating EMR Resources using ABAC

## v6.0.1 - August 10th, 2021
* Fixes an issue in the way `emr_managed_master_sg_ids` and `emr_managed_core_sg_ids` are passed to the AWS provider that would make Terraform need to recreate the cluster in every plan

## v6.0.0 - July 13th, 2021
* Removes creation of security groups except for internal use within the cluster
* Removes security group input variables:
  * `emr_managed_master_sg_id`
  * `emr_additional_master_sg_id`
  * `emr_managed_core_sg_id`
  * `emr_additional_core_sg_id`
  * `emr_service_access_sg_id`
* Replaces above 5 variables with:
  * `emr_managed_master_sg_ids`
  * `emr_managed_core_sg_ids`
* Adds a new ports module
* Updates examples to use new ports module

## v5.2.0 - July 13th 2021
* Deprecates `additional_tags` in favor of `tags`

## v5.1.0 - July 6th, 2021
* Adds new variable `permissions_boundary` to set the permissions boundary for all IAM Roles created by the module

## v5.0.0 - July 1st, 2021
* Remove wildcards from IAM policies where possible
* Removes policy entirely for the ec2 role

## v4.1.0 - June 29, 2021
* Open port 16030 on region servers to allow collection of HBase metrics

## v4.0.0 - June 15, 2021
* Update cluster to use instance fleets, for a mix of on-demand and spot instances
* Changes variables:
  * master_instance_group_name ==> master_instance_fleet_name
  * core_instance_group_name ==> core_instance_group_name
* Removes variables:
  * master_group_instance_count
  * core_group_instance_count
* Adds variables:
  * master_instance_on_demand_count
  * master_instance_spot_count
  * master_bid_price_as_percentage_of_on_demand_price
  * master_block_duration_minutes
  * master_timeout_action
  * master_timeout_duration_minutes
  * core_instance_on_demand_count
  * core_instance_spot_count
  * core_bid_price_as_percentage_of_on_demand_price
  * core_block_duration_minutes
  * core_timeout_action
  * core_timeout_duration_minutes
* Changes output:
  * core_group_instance_count ==> core_fleet_instance_count
* Adds output:
  * master_fleet_instance_count

## v3.0.1 - April 27th 2021
* Upgrades and pins `terraform-aws-modules/key-pair/aws` to version 1.0.0

## v3.0.0 - April 13th 2021
* Updates minimum AWS provider version to 3.36.0
* Sets default value for `custom_ami_id` to `null` to achieve the intended behavior
* Updates the versions of other modules in the examples

## v2.1.0 - April 9th 2021
* Adds new variables `core_bid_price` and `master_bid_price` for setting bid price for spot
  instances

## v2.0.0 - April 8th 2021
* Upgrades module to require terraform 13.x
* Fixes a bug that sometimes required running apply twice when making configuration changes

## v1.2.0 - April 7th 2021
*  Adds new variable `arn_partition` to set the partition of any ARNs referenced in this module

## v1.1.0 - April 7th 2021
*  Adds new variable `custom_ami_id` to set the ID of a custom Amazon EBS-backed Linux AMI

## v1.0.0 - February 3rd 2021
* Allows `utility_script_bucket_key` to have any name
* Removes support for consistent view, which is no longer necessary since Amazon S3 supports
  strong read-after-write consistency.
* Removes variables:
  * `emrfs_metadata_table_name`
  * `emrfs_metadata_read_capacity`
  * `emrfs_metadata_write_capacity`
  * `aws_region_of_dynamodb_table`
* To upgrade, remove those variables and run `terraform apply` _twice_. The first apply will
  update the configuration, and the second apply will recreate the cluster.

## v0.13.0 - January 12th 2021
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
