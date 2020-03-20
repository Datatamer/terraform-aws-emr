# Tamr AWS EMR IAM Terraform Module
This terraform module creates the required IAM roles and instance profile to run an EMR Hbase cluster.

# Example
```
module "emr_hbase_iam" {
  source = "" 
  aws_account_id = "1234567890"
  s3_bucket_name_for_hbase_logs = "emr-hbase-logs"
  s3_bucket_name_for_hbase_root_directory = "emr-hbase-rootdir"
}
```

# Resources created
This terraform module creates the following resources:
* 2 IAM Policies:
    1) Minimum required EMR service policy
    2) Minimum required EMR EC2 policy
* 2 IAM roles:
    1) Tamr EMR service IAM role
    2) Tamr EMR EC2 IAM role
* 1 IAM instance profile for EMR EC2 instances

# Variables
## Inputs
* `aws_account_id` (required): Account ID of the AWS account
* `s3_bucket_name_for_hbase_root_directory` (required): Name of the AWS S3 bucket used as the EMR Hbase root directory
* `s3_bucket_name_for_hbase_logs` (required): Name of the AWS S3 bucket used for EMR Hbase logs   
* `emrfs_metadata_table_name` (optional): Name of the Dynamodb table used for EMRFS metadata
* `aws_region` (optional): AWS region where the Dynamodb table for EMRFS is located
* `emr_service_role_name` (optional): Name for the IAM service role for EMR cluster
* `emr_ec2_role_name` (optional): Name for the IAM role created for EC2 instance profile
* `emr_ec2_instance_profile_name` (optional): Name for the EC2 instance profile used in EMR cluster config
* `additional-tags` (optional): Additional tags that the user can add

## Outputs
* `emr_service_role_arn`: ARN for the EMR service IAM role created
* `emr_ec2_role_arn`: ARN for the EMR EC2 IAM role created
* `emr_ec2_instance_profile_arn`: ARN for the IAM instance profile created

# References
* Default IAM roles for EMR: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-roles.html
* Service role for EMR: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-role.html
* EC2 role for EMR (Instance Profile): https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-role-for-ec2.html
* Best Practices for EMR: https://aws.amazon.com/blogs/big-data/best-practices-for-securing-amazon-emr/

# Development
## Releasing new versions
* Update version contained in `VERSION`
* Document changes in `CHANGELOG.md`
* Create a tag in github for the commit associated with the version

# License
Apache 2 Licensed. See LICENSE for full details.
