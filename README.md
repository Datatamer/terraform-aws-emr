# TAMR AWS EMR Terraform Module
This module creates the entire AWS infrastructure required for Tamr to work with AWS EMR. Currently, this module supports 3 patterns of use:
1. Creation of infrastruction for static HBase cluster
2. Creation of infrastructure for static Spark cluster
3. Creation of infrastructure for ephemeral Spark cluster (the cluster itself is not created)

# Examples
## Minimal
Fully working examples for each pattern of use. These examples might require extra resources to run the examples.
### Invokes the root module:
- [Static HBase Cluster](https://github.com/Datatamer/terraform-aws-emr/tree/master/examples/static-hbase)
- [Static Spark Cluster](https://github.com/Datatamer/terraform-aws-emr/tree/master/examples/static-spark)
### Invokes submodules:
- [Ephemeral Spark Cluster](https://github.com/Datatamer/terraform-aws-emr/tree/master/examples/ephemeral-spark)

# Resources Created
This module creates:
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
* 1 bucket object with the cluster's JSON configuration in the root directory S3 bucket

If you are creating a static HBase or Spark cluster, this module also creates:
* 1 EMR Cluster and associated EMR Security Configuration

Note: For creating the logs and root directory buckets and/or S3-related permissions, use the [terraform-aws-s3](https://github.com/Datatamer/terraform-aws-s3) module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.36.0 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| applications | List of applications to run on EMR | `list(string)` | n/a | yes |
| bucket\_name\_for\_logs | S3 bucket name for cluster logs. | `string` | n/a | yes |
| bucket\_name\_for\_root\_directory | S3 bucket name for storing root directory | `string` | n/a | yes |
| emr\_config\_file\_path | Path to the EMR JSON configuration file. Please include the file name as well. | `string` | n/a | yes |
| emr\_managed\_core\_sg\_ids | List of EMR managed core security group ids | `list(string)` | n/a | yes |
| emr\_managed\_master\_sg\_ids | List of EMR managed master security group ids | `list(string)` | n/a | yes |
| emr\_service\_access\_sg\_ids | List of EMR service access security group ids | `list(string)` | n/a | yes |
| key\_pair\_name | Name of the Key Pair that will be attached to the EC2 instances | `string` | n/a | yes |
| s3\_policy\_arns | List of policy ARNs to attach to EMR EC2 instance profile. | `list(string)` | n/a | yes |
| subnet\_id | ID of the subnet where the EMR cluster will be created | `string` | n/a | yes |
| vpc\_id | VPC ID of the network | `string` | n/a | yes |
| abac\_valid\_tags | Valid tags for maintaining resources when using ABAC IAM Policies with Tag Conditions. Make sure `tags` contain a key value specified here. | `map(list(string))` | `{}` | no |
| additional\_tags | [DEPRECATED: Use `tags` instead] Additional tags to be attached to the resources created. | `map(string)` | `{}` | no |
| arn\_partition | The partition in which the resource is located. A partition is a group of AWS Regions.<br>  Each AWS account is scoped to one partition.<br>  The following are the supported partitions:<br>    aws -AWS Regions<br>    aws-cn - China Regions<br>    aws-us-gov - AWS GovCloud (US) Regions | `string` | `"aws"` | no |
| bootstrap\_actions | Ordered list of bootstrap actions that will be run before Hadoop is started on the cluster nodes. | <pre>list(object({<br>    name = string<br>    path = string<br>    args = list(string)<br>  }))</pre> | `[]` | no |
| bucket\_path\_to\_logs | Path in logs bucket to store cluster logs e.g. mycluster/logs | `string` | `""` | no |
| cluster\_name | Name for the EMR cluster to be created | `string` | `"TAMR-EMR-Cluster"` | no |
| core\_bid\_price | Bid price for each EC2 instance in the core instance group, expressed in USD. By setting this attribute,<br>  the instance group is being declared as a Spot Instance, and will implicitly create a Spot request.<br>  Leave this blank to use On-Demand Instances | `string` | `""` | no |
| core\_bid\_price\_as\_percentage\_of\_on\_demand\_price | Bid price as percentage of on-demand price for core instances | `number` | `100` | no |
| core\_block\_duration\_minutes | Duration for core spot instances, in minutes | `number` | `0` | no |
| core\_ebs\_size | The volume size, in gibibytes (GiB). | `string` | `"500"` | no |
| core\_ebs\_type | Type of volumes to attach to the core nodes. Valid options are gp2, io1, standard and st1 | `string` | `"gp2"` | no |
| core\_ebs\_volumes\_count | Number of volumes to attach to the core nodes | `number` | `1` | no |
| core\_instance\_fleet\_name | Name for the core instance fleet | `string` | `"CoreInstanceFleet"` | no |
| core\_instance\_on\_demand\_count | Number of on-demand instances for the spot instance fleet | `number` | `1` | no |
| core\_instance\_spot\_count | Number of spot instances for the spot instance fleet | `number` | `0` | no |
| core\_instance\_type | The EC2 instance type of the core nodes | `string` | `"m4.xlarge"` | no |
| core\_timeout\_action | Timeout action for core instances | `string` | `"SWITCH_TO_ON_DEMAND"` | no |
| core\_timeout\_duration\_minutes | Spot provisioning timeout for core instances, in minutes | `number` | `10` | no |
| create\_static\_cluster | True if the module should create a static cluster. False if the module should create supporting infrastructure but not the cluster itself. | `bool` | `true` | no |
| custom\_ami\_id | The ID of a custom Amazon EBS-backed Linux AMI | `string` | `null` | no |
| emr\_ec2\_iam\_policy\_name | Name for the IAM policy attached to the EMR service role | `string` | `"tamr-emr-ec2-policy"` | no |
| emr\_ec2\_instance\_profile\_name | Name of the new instance profile for EMR EC2 instances | `string` | `"tamr_emr_ec2_instance_profile"` | no |
| emr\_ec2\_role\_name | Name of the new IAM role for EMR EC2 instances | `string` | `"tamr_emr_ec2_role"` | no |
| emr\_managed\_core\_sg\_name | Name for the EMR managed core security group | `string` | `"TAMR-EMR-Core"` | no |
| emr\_managed\_master\_sg\_name | Name for the EMR managed master security group | `string` | `"TAMR-EMR-Master"` | no |
| emr\_managed\_sg\_name | Name for the EMR managed security group | `string` | `"TAMR-EMR-Internal"` | no |
| emr\_service\_access\_sg\_name | Name for the EMR Service Access security group | `string` | `"TAMR-EMR-Service-Access"` | no |
| emr\_service\_iam\_policy\_name | Name for the IAM policy attached to the EMR Service role | `string` | `"tamr-emr-service-policy"` | no |
| emr\_service\_role\_name | Name of the new IAM service role for the EMR cluster | `string` | `"tamr_emr_service_role"` | no |
| enable\_http\_port | EMR services like Ganglia run on the http port | `bool` | `false` | no |
| hadoop\_config\_path | Path in root directory bucket to upload Hadoop config to | `string` | `"config/hadoop/conf/"` | no |
| hbase\_config\_path | Path in root directory bucket to upload HBase config to | `string` | `"config/hbase/conf.dist/"` | no |
| json\_configuration\_bucket\_key | Key (i.e. path) of JSON configuration bucket object in the root directory bucket | `string` | `"config.json"` | no |
| master\_bid\_price | Bid price for each EC2 instance in the master instance group, expressed in USD. By setting this attribute,<br>  the instance group is being declared as a Spot Instance, and will implicitly create a Spot request.<br>  Leave this blank to use On-Demand Instances | `string` | `""` | no |
| master\_bid\_price\_as\_percentage\_of\_on\_demand\_price | Bid price as percentage of on-demand price for master instances | `number` | `100` | no |
| master\_block\_duration\_minutes | Duration for master spot instances, in minutes | `number` | `0` | no |
| master\_ebs\_size | The volume size, in gibibytes (GiB). | `string` | `"100"` | no |
| master\_ebs\_type | Type of volumes to attach to the master nodes. Valid options are gp2, io1, standard and st1 | `string` | `"gp2"` | no |
| master\_ebs\_volumes\_count | Number of volumes to attach to the master nodes | `number` | `1` | no |
| master\_instance\_fleet\_name | Name for the master instance fleet | `string` | `"MasterInstanceFleet"` | no |
| master\_instance\_on\_demand\_count | Number of on-demand instances for the master instance fleet | `number` | `1` | no |
| master\_instance\_spot\_count | Number of spot instances for the master instance fleet | `number` | `0` | no |
| master\_instance\_type | The EC2 instance type of the master nodes | `string` | `"m4.xlarge"` | no |
| master\_timeout\_action | Timeout action for master instances | `string` | `"SWITCH_TO_ON_DEMAND"` | no |
| master\_timeout\_duration\_minutes | Spot provisioning timeout for master instances, in minutes | `number` | `10` | no |
| permissions\_boundary | ARN of the policy that will be used to set the permissions boundary for all IAM Roles created by this module | `string` | `null` | no |
| release\_label | The release label for the Amazon EMR release. | `string` | `"emr-5.29.0"` | no |
| require\_abac\_for\_subnet | If abac\_valid\_tags is specified, choose whether or not to require ABAC also for actions related to the subnet | `bool` | `true` | no |
| security\_configuration | The name of an EMR Security Configuration | `string` | `null` | no |
| tags | A map of tags to add to all resources. Replaces `additional_tags`. | `map(string)` | `{}` | no |
| utility\_script\_bucket\_key | Key (i.e. path) to upload the utility script to | `string` | `"util/upload_hbase_config.sh"` | no |

## Outputs

| Name | Description |
|------|-------------|
| core\_ebs\_size | The core EBS volume size, in gibibytes (GiB). |
| core\_ebs\_type | The core EBS volume size, in gibibytes (GiB). |
| core\_ebs\_volumes\_count | Number of volumes to attach to the core nodes |
| core\_fleet\_instance\_count | Number of on-demand and spot core instances configured |
| core\_instance\_type | The EC2 instance type of the core nodes |
| emr\_ec2\_instance\_profile\_arn | ARN of the EMR EC2 instance profile created |
| emr\_ec2\_instance\_profile\_name | Name of the EMR EC2 instance profile created |
| emr\_ec2\_role\_arn | ARN of the EMR EC2 role created for EC2 instances |
| emr\_managed\_core\_sg\_ids | List of security group ids of the EMR Core Security Group |
| emr\_managed\_master\_sg\_ids | List of security group ids of the EMR Master Security Group |
| emr\_managed\_sg\_id | Security group id of the EMR Managed Security Group for internal communication |
| emr\_service\_access\_sg\_ids | List of security group ids of the EMR Service Access Security Group |
| emr\_service\_role\_arn | ARN of the EMR service role created |
| emr\_service\_role\_name | Name of the EMR service role created |
| hbase\_config\_path | Path in the root directory bucket that HBase config was uploaded to. |
| json\_config\_s3\_key | The name of the json configuration object in the bucket. |
| log\_uri | The path to the S3 location where logs for this cluster are stored. |
| master\_ebs\_size | The master EBS volume size, in gibibytes (GiB). |
| master\_ebs\_type | Type of volumes to attach to the master nodes. Valid options are gp2, io1, standard and st1 |
| master\_ebs\_volumes\_count | Number of volumes to attach to the master nodes |
| master\_fleet\_instance\_count | Number of on-demand and spot master instances configured |
| master\_instance\_type | The EC2 instance type of the master nodes |
| release\_label | The release label for the Amazon EMR release. |
| subnet\_id | ID of the subnet where EMR cluster was created |
| tamr\_emr\_cluster\_id | Identifier for the AWS EMR cluster created. Empty string if set up infrastructure for ephemeral cluster. |
| tamr\_emr\_cluster\_name | Name of the AWS EMR cluster created |
| upload\_config\_script\_s3\_key | The name of the upload config script object in the bucket. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

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
* [AWS EMR Security Configuration](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-create-security-configuration.html)
* [AWS EMR Bootstrap Actions](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-bootstrap.html)

# Development
## Generating Docs
Run `make terraform/docs` to generate the section of docs around terraform inputs, outputs and requirements.

## Checkstyles
Run `make lint`, this will run terraform fmt, in addition to a few other checks to detect whitespace issues.
NOTE: this requires having docker working on the machine running the test

## Releasing new versions
* Update version contained in `VERSION`
* Document changes in `CHANGELOG.md`
* Create a tag in github for the commit associated with the version

# License
Apache 2 Licensed. See LICENSE for full details.
