# Tamr AWS EMR IAM Terraform Module
This Terraform module creates the required IAM roles and instance profile to run an EMR cluster.

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
| terraform | >= 0.13 |
| aws | >= 3.36, !=4.0.0, !=4.1.0, !=4.2.0, !=4.3.0, !=4.4.0, !=4.5.0, !=4.6.0, !=4.7.0, !=4.8.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.36, !=4.0.0, !=4.1.0, !=4.2.0, !=4.3.0, !=4.4.0, !=4.5.0, !=4.6.0, !=4.7.0, !=4.8.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_policy\_arns | List of policy ARNs to attach to EMR EC2 instance profile. | `list(string)` | n/a | yes |
| s3\_bucket\_name\_for\_logs | S3 bucket name/directory for cluster logs. | `string` | n/a | yes |
| s3\_bucket\_name\_for\_root\_directory | S3 bucket name for storing root directory | `string` | n/a | yes |
| vpc\_id | VPC ID of the network | `string` | n/a | yes |
| abac\_valid\_tags | Valid tags for maintaining resources when using ABAC IAM Policies with Tag Conditions. Make sure `tags` contain a key value specified here. | `map(list(string))` | `{}` | no |
| arn\_partition | The partition in which the resource is located. A partition is a group of AWS Regions.<br>  Each AWS account is scoped to one partition.<br>  The following are the supported partitions:<br>    aws -AWS Regions<br>    aws-cn - China Regions<br>    aws-us-gov - AWS GovCloud (US) Regions | `string` | `"aws"` | no |
| emr\_ec2\_iam\_policy\_name | Name for the IAM policy attached to the EMR service role | `string` | `"tamr-emr-ec2-policy"` | no |
| emr\_ec2\_instance\_profile\_name | Name of the new instance profile for EMR EC2 instances | `string` | `"tamr_emr_ec2_instance_profile"` | no |
| emr\_ec2\_role\_name | Name of the new IAM role for EMR EC2 instances | `string` | `"tamr_emr_ec2_role"` | no |
| emr\_service\_iam\_policy\_name | Name for the IAM policy attached to the EMR Service role | `string` | `"tamr-emr-service-policy"` | no |
| emr\_service\_role\_name | Name of the new IAM service role for the EMR cluster | `string` | `"tamr_emr_service_role"` | no |
| permissions\_boundary | ARN of the policy that will be used to set the permissions boundary for all IAM Roles created by this module | `string` | `null` | no |
| require\_abac\_for\_subnet | If abac\_valid\_tags is specified, choose whether or not to require ABAC also for actions related to the subnet | `bool` | `true` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

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
