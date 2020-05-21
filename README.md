# TAMR AWS EMR Hbase root module
This module creates the entire AWS infrastructure required for Tamr to work with AWS EMR Hbase

# Example
A complete working example is specified in the `/examples` directory.

# Resources Created
This modules creates:
* 2 S3 buckets
    * One S3 bucket for EMR Hbase logs
    * One S3 bucket for EMR Hbase Root Directory
* 5 Security Groups
    * One security group for EMR Managed Master instance(s)
    * One security group for EMR Managed Core instance(s)
    * One security group for additional ports for Master instance(s)
    * One security group for additional ports for Core instance(s)
    * One service access security group that can be attached to any instance
* Security group rules. The number of the security group rules varies based on the number of CIDRs or source SGs provided.
* 2 IAM Policies:
    * Minimum required EMR service policy
    * Minimum required EMR EC2 policy
* 2 IAM roles:
    * Tamr EMR service IAM role
    * Tamr EMR EC2 IAM role
* 1 IAM instance profile for EMR EC2 instances
* 1 Dynamodb table for EMRFS
* 1 EMR Hbase Cluster

# Variables 
## Inputs
* `aws_account_id` (required): Account ID of the AWS account
* `vpc_id` (required): VPC id of the network
* `key_pair_name` (required): Name of the Key Pair that will be attached to the EC2 instances
* `subnet_id` (required): ID of the subnet where the emr cluster will be created
* `emr_hbase_config_file_path` (required): Path to the EMR Hbase config file. Please include the file name as well
* `bucket_name_for_logs` (required): S3 bucket name for EMR Hbase logs
* `bucket_name_for_hbase_root_dir` (required): S3 bucket name for EMR Hbase root directory
* `cluster_name` (optional): Name for the EMR Hbase cluster to be created
* `tamr_cidrs` (optional): List of CIDRs for Tamr
* `tamr_sgs` (optional): Security Groups for the Tamr Instance
* `emrfs_metadata_table_name` (optional): Table name of EMRFS metadata table in Dynamodb
* `emrfs_metadata_read_capacity` (optional): Read capacity units of the dynamodb table used for EMRFS metadata
* `emrfs_metadata_write_capacity` (optional): Write capacity units of the dynamodb table used for EMRFS metadata
* `additional_tags` (optional): Additional tags to be attached to the resources created
* `aws_region_of_dynamodb_table` (optional): AWS region where the Dynamodb table for EMRFS metadata is located
* `emr_service_iam_policy_name` (optional): Name for the IAM policy attached to the EMR Service role
* `emr_ec2_iam_policy_name` (optional): Name for the IAM policy attached to the EMR Service role
* `emr_service_role_name` (optional): Name for the new iam service role for the EMR Hbase cluster
* `emr_ec2_role_name` (optional): Name for the new iam role for the EMR Hbase EC2 instances
* `emr_ec2_instance_profile_name` (optional): Name for the new instance profile for the EMR Hbase EC2 instances
* `master_instance_group_name` (optional): Name for the master instance group
* `core_instance_group_name` (optional): Name for the core instance group
* `release_label` (optional): The release label for the Amazon EMR release
* `master_instance_type` (optional): The EC2 instance type of the master nodes
* `core_instance_type` (optional): The EC2 instance type of the core nodes
* `master_group_instance_count` (optional): Number of instances for the master instance group. Must be 1 or 3.
* `core_group_instance_count` (optional): Number of Amazon EC2 instances used to execute the job flow
* `emr_managed_master_sg_name` (optional): Name for the EMR managed master security group
* `emr_managed_core_sg_name` (optional): Name for the EMR managed core security group
* `emr_additional_master_sg_name` (optional): Name for the EMR additional master security group
* `emr_additional_core_sg_name` (optional): Name for the EMR additional core security group
* `emr_service_access_sg_name` (optional): Name for the EMR service access security group

## Outputs
* `s3_bucket_name_for_logs`: Name of the S3 bucket used for EMR Hbase logs
* `s3_bucket_name_for_hbase_rootdir`: Name of the S3 bucket used for EMR Hbase root directory
* `emr_managed_master_sg_id`: Security group id of the EMR Managed Master Security Group
* `emr_managed_core_sg_id`: Security group id of the EMR Managed Core Security Group
* `emr_additional_master_sg_id`: Security group id of the EMR Additional Master Security Group
* `emr_additional_core_sg_id`: Security group id of the EMR Additional Core Security Group
* `emr_service_access_sg_id`: Security group id of Service Access Security Group
* `emr_service_role_arn`: ARN for the EMR service IAM role created
* `emr_ec2_role_arn`: ARN for the EMR EC2 IAM role created
* `emr_ec2_instance_profile_arn`: ARN for the IAM instance profile created
* `tamr_emr_cluster_id`: Identifier for the AWS EMR cluster created

# References
This repo is based on:
* [Terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [AWS EMR HBase](https://aws.amazon.com/emr/features/hbase/)
* [AWS EMR Cluster Terraform Docs](https://www.terraform.io/docs/providers/aws/r/emr_cluster.html)
* [Default IAM roles for EMR](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-roles.html)
* [Service role for EMR](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-role.html)
* [EC2 role for EMR (Instance Profile)](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-role-for-ec2.html)
* [Best Practices for EMR](https://aws.amazon.com/blogs/big-data/best-practices-for-securing-amazon-emr/)
* [AWS EMR Security Groups](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-man-sec-groups.html)
* [AWS EMR Additional Security Groups](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-sg-specify.html)

# Development
## Releasing new versions
* Updated version contained in `VERSION`
* Documented changes in `CHANGELOG.md`

# License
Apache 2 Licensed. See LICENSE for full details.
