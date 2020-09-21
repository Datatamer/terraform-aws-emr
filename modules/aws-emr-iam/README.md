# Tamr AWS EMR IAM Terraform Module
This terraform module creates the required IAM roles and instance profile to run an EMR Hbase cluster.

# Example
```
module "emr_hbase_iam" {
  source = "git::git@github.com:Datatamer/terraform-aws-emr-hbase.git//modules/aws-emr-iam?ref=0.8.1"
  aws_account_id = "1234567890"
  s3_bucket_name_for_hbase_logs = "example-emr-hbase-logs"
  s3_bucket_name_for_hbase_root_directory = "example-emr-hbase-rootdir"
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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_account\_id | Account ID for the AWS account | `string` | n/a | yes |
| s3\_bucket\_name\_for\_hbase\_logs | S3 bucket name/directory of EMR Hbase logs | `string` | n/a | yes |
| s3\_bucket\_name\_for\_hbase\_root\_directory | S3 Bucket name of the hbase root directory | `string` | n/a | yes |
| additional\_tags | Additional tags to be attached to the resources created | `map(string)` | `{}` | no |
| aws\_region\_of\_dynamodb\_table | AWS region where the Dynamodb table for EMRFS metadata is located | `string` | `"us-east-1"` | no |
| emr\_ec2\_iam\_policy\_name | Name for the IAM policy attached to the EMR Service role | `string` | `"tamr-emr-ec2-policy"` | no |
| emr\_ec2\_instance\_profile\_name | Name for the new instance profile for the EMR Hbase EC2 instances | `string` | `"tamr_emr_ec2_instance_profile"` | no |
| emr\_ec2\_role\_name | Name for the new iam role for the EMR Hbase EC2 instances | `string` | `"tamr_emr_ec2_role"` | no |
| emr\_service\_iam\_policy\_name | Name for the IAM policy attached to the EMR Service role | `string` | `"tamr-emr-hbase-policy"` | no |
| emr\_service\_role\_name | Name for the new iam service role for the EMR Hbase cluster | `string` | `"tamr_emr_service_role"` | no |
| emrfs\_metadata\_table\_name | Table name of EMRFS metadata table in Dynamodb | `string` | `"EmrFSMetadata"` | no |

## Outputs

| Name | Description |
|------|-------------|
| emr\_ec2\_instance\_profile\_arn | ARN of the EMR Hbase service role created |
| emr\_ec2\_role\_arn | ARN of the EMR Hbase role created for EC2 instances |
| emr\_service\_role\_arn | ARN of the EMR Hbase service role created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
* Default IAM roles for EMR: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-roles.html
* Service role for EMR: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-role.html
* EC2 role for EMR (Instance Profile): https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-role-for-ec2.html
* Best Practices for EMR: https://aws.amazon.com/blogs/big-data/best-practices-for-securing-amazon-emr/
