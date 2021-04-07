# Tamr AWS EMR IAM Terraform Module
This terraform module creates the required IAM roles and instance profile to run an EMR cluster.

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "emr_iam" {
  source                                  = "git::git@github.com:Datatamer/terraform-aws-emr.git//modules/aws-emr-iam?ref=2.0.0"
  s3_bucket_name_for_logs                 = "example-emr-logs"
  s3_bucket_name_for_root_directory       = "example-emr-rootdir"
  s3_policy_arns                          = ["arn:aws:iam::123456789101:policy/example-rootdir-read-write", "arn:aws:iam::123456789101:policy/example-logs-read-write"]
}
```
## Minimal
This example directly invokes this submodule.
- [Ephemeral Spark Example](https://github.com/Datatamer/terraform-aws-emr/tree/master/examples/ephemeral-spark)

For creating the S3 buckets and/or S3-related permissions, use the [terraform-aws-s3](https://github.com/Datatamer/terraform-aws-s3) module.

# Resources created
This module creates:
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
| aws | >= 2.45.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.45.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| s3\_bucket\_name\_for\_logs | S3 bucket name/directory for cluster logs. | `string` | n/a | yes |
| s3\_bucket\_name\_for\_root\_directory | S3 bucket name for storing root directory | `string` | n/a | yes |
| s3\_policy\_arns | List of policy ARNs to attach to EMR EC2 instance profile. | `list(string)` | n/a | yes |
| additional\_tags | Additional tags to be attached to the resources created | `map(string)` | `{}` | no |
| emr\_ec2\_iam\_policy\_name | Name for the IAM policy attached to the EMR service role | `string` | `"tamr-emr-ec2-policy"` | no |
| emr\_ec2\_instance\_profile\_name | Name of the new instance profile for EMR EC2 instances | `string` | `"tamr_emr_ec2_instance_profile"` | no |
| emr\_ec2\_role\_name | Name of the new IAM role for EMR EC2 instances | `string` | `"tamr_emr_ec2_role"` | no |
| emr\_service\_iam\_policy\_name | Name for the IAM policy attached to the EMR Service role | `string` | `"tamr-emr-service-policy"` | no |
| emr\_service\_role\_name | Name of the new IAM service role for the EMR cluster | `string` | `"tamr_emr_service_role"` | no |

## Outputs

| Name | Description |
|------|-------------|
| emr\_ec2\_instance\_profile\_arn | ARN of the EMR EC2 instance profile created |
| emr\_ec2\_instance\_profile\_name | Name of the EMR EC2 instance profile created |
| emr\_ec2\_role\_arn | ARN of the EMR role created for EC2 instances |
| emr\_service\_role\_arn | ARN of the EMR service role created |
| emr\_service\_role\_name | Name of the EMR service role created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
* Default IAM roles for EMR: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-roles.html
* Service role for EMR: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-role.html
* EC2 role for EMR (Instance Profile): https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-role-for-ec2.html
* Best Practices for EMR: https://aws.amazon.com/blogs/big-data/best-practices-for-securing-amazon-emr/
