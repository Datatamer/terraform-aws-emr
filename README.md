<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_emr-cluster"></a> [emr-cluster](#module\_emr-cluster) | ./modules/aws-emr-cluster | n/a |
| <a name="module_emr-cluster-config"></a> [emr-cluster-config](#module\_emr-cluster-config) | ./modules/aws-emr-config | n/a |
| <a name="module_emr-iam"></a> [emr-iam](#module\_emr-iam) | ./modules/aws-emr-iam | n/a |
| <a name="module_emr-sgs"></a> [emr-sgs](#module\_emr-sgs) | ./modules/aws-emr-sgs | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_applications"></a> [applications](#input\_applications) | List of applications to run on EMR | `list(string)` | n/a | yes |
| <a name="input_bucket_name_for_logs"></a> [bucket\_name\_for\_logs](#input\_bucket\_name\_for\_logs) | S3 bucket name for cluster logs. | `string` | n/a | yes |
| <a name="input_bucket_name_for_root_directory"></a> [bucket\_name\_for\_root\_directory](#input\_bucket\_name\_for\_root\_directory) | S3 bucket name for storing root directory | `string` | n/a | yes |
| <a name="input_emr_config_file_path"></a> [emr\_config\_file\_path](#input\_emr\_config\_file\_path) | Path to the EMR JSON configuration file. Please include the file name as well. | `string` | n/a | yes |
| <a name="input_emr_managed_core_sg_ids"></a> [emr\_managed\_core\_sg\_ids](#input\_emr\_managed\_core\_sg\_ids) | List of EMR managed core security group ids | `list(string)` | n/a | yes |
| <a name="input_emr_managed_master_sg_ids"></a> [emr\_managed\_master\_sg\_ids](#input\_emr\_managed\_master\_sg\_ids) | List of EMR managed master security group ids | `list(string)` | n/a | yes |
| <a name="input_emr_service_access_sg_ids"></a> [emr\_service\_access\_sg\_ids](#input\_emr\_service\_access\_sg\_ids) | List of EMR service access security group ids | `list(string)` | n/a | yes |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | Name of the Key Pair that will be attached to the EC2 instances | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet where the EMR cluster will be created | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID of the network | `string` | n/a | yes |
| <a name="input_abac_valid_tags"></a> [abac\_valid\_tags](#input\_abac\_valid\_tags) | Valid tags for maintaining resources when using ABAC IAM Policies with Tag Conditions. Make sure `tags` contain a key value specified here. | `map(list(string))` | `{}` | no |
| <a name="input_additional_policy_arns"></a> [additional\_policy\_arns](#input\_additional\_policy\_arns) | List of policy ARNs to attach to EMR EC2 instance profile. | `list(string)` | `[]` | no |
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | [DEPRECATED: Use `tags` instead] Additional tags to be attached to the resources created. | `map(string)` | `{}` | no |
| <a name="input_arn_partition"></a> [arn\_partition](#input\_arn\_partition) | The partition in which the resource is located. A partition is a group of AWS Regions.<br>  Each AWS account is scoped to one partition.<br>  The following are the supported partitions:<br>    aws -AWS Regions<br>    aws-cn - China Regions<br>    aws-us-gov - AWS GovCloud (US) Regions | `string` | `"aws"` | no |
| <a name="input_bootstrap_actions"></a> [bootstrap\_actions](#input\_bootstrap\_actions) | Ordered list of bootstrap actions that will be run before Hadoop is started on the cluster nodes. | <pre>list(object({<br>    name = string<br>    path = string<br>    args = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_bucket_path_to_logs"></a> [bucket\_path\_to\_logs](#input\_bucket\_path\_to\_logs) | Path in logs bucket to store cluster logs e.g. mycluster/logs | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name for the EMR cluster to be created | `string` | `"TAMR-EMR-Cluster"` | no |
| <a name="input_core_bid_price"></a> [core\_bid\_price](#input\_core\_bid\_price) | Bid price for each EC2 instance in the core instance group, expressed in USD. By setting this attribute,<br>  the instance group is being declared as a Spot Instance, and will implicitly create a Spot request.<br>  Leave this blank to use On-Demand Instances | `string` | `""` | no |
| <a name="input_core_bid_price_as_percentage_of_on_demand_price"></a> [core\_bid\_price\_as\_percentage\_of\_on\_demand\_price](#input\_core\_bid\_price\_as\_percentage\_of\_on\_demand\_price) | Bid price as percentage of on-demand price for core instances | `number` | `100` | no |
| <a name="input_core_block_duration_minutes"></a> [core\_block\_duration\_minutes](#input\_core\_block\_duration\_minutes) | Duration for core spot instances, in minutes | `number` | `0` | no |
| <a name="input_core_ebs_size"></a> [core\_ebs\_size](#input\_core\_ebs\_size) | The volume size, in gibibytes (GiB). | `string` | `"500"` | no |
| <a name="input_core_ebs_type"></a> [core\_ebs\_type](#input\_core\_ebs\_type) | Type of volumes to attach to the core nodes. Valid options are gp2, io1, standard and st1 | `string` | `"gp2"` | no |
| <a name="input_core_ebs_volumes_count"></a> [core\_ebs\_volumes\_count](#input\_core\_ebs\_volumes\_count) | Number of volumes to attach to the core nodes | `number` | `1` | no |
| <a name="input_core_instance_fleet_name"></a> [core\_instance\_fleet\_name](#input\_core\_instance\_fleet\_name) | Name for the core instance fleet | `string` | `"CoreInstanceFleet"` | no |
| <a name="input_core_instance_on_demand_count"></a> [core\_instance\_on\_demand\_count](#input\_core\_instance\_on\_demand\_count) | Number of on-demand instances for the spot instance fleet | `number` | `1` | no |
| <a name="input_core_instance_spot_count"></a> [core\_instance\_spot\_count](#input\_core\_instance\_spot\_count) | Number of spot instances for the spot instance fleet | `number` | `0` | no |
| <a name="input_core_instance_type"></a> [core\_instance\_type](#input\_core\_instance\_type) | The EC2 instance type of the core nodes | `string` | `"m4.xlarge"` | no |
| <a name="input_core_timeout_action"></a> [core\_timeout\_action](#input\_core\_timeout\_action) | Timeout action for core instances | `string` | `"SWITCH_TO_ON_DEMAND"` | no |
| <a name="input_core_timeout_duration_minutes"></a> [core\_timeout\_duration\_minutes](#input\_core\_timeout\_duration\_minutes) | Spot provisioning timeout for core instances, in minutes | `number` | `10` | no |
| <a name="input_create_static_cluster"></a> [create\_static\_cluster](#input\_create\_static\_cluster) | True if the module should create a static cluster. False if the module should create supporting infrastructure but not the cluster itself. | `bool` | `true` | no |
| <a name="input_custom_ami_id"></a> [custom\_ami\_id](#input\_custom\_ami\_id) | The ID of a custom Amazon EBS-backed Linux AMI | `string` | `null` | no |
| <a name="input_emr_ec2_instance_profile_name"></a> [emr\_ec2\_instance\_profile\_name](#input\_emr\_ec2\_instance\_profile\_name) | Name of the new instance profile for EMR EC2 instances | `string` | `"tamr_emr_ec2_instance_profile"` | no |
| <a name="input_emr_ec2_role_name"></a> [emr\_ec2\_role\_name](#input\_emr\_ec2\_role\_name) | Name of the new IAM role for EMR EC2 instances | `string` | `"tamr_emr_ec2_role"` | no |
| <a name="input_emr_managed_sg_name"></a> [emr\_managed\_sg\_name](#input\_emr\_managed\_sg\_name) | Name for the EMR managed security group | `string` | `"TAMR-EMR-Internal"` | no |
| <a name="input_emr_service_iam_policy_name"></a> [emr\_service\_iam\_policy\_name](#input\_emr\_service\_iam\_policy\_name) | Name for the IAM policy attached to the EMR Service role | `string` | `"tamr-emr-service-policy"` | no |
| <a name="input_emr_service_role_name"></a> [emr\_service\_role\_name](#input\_emr\_service\_role\_name) | Name of the new IAM service role for the EMR cluster | `string` | `"tamr_emr_service_role"` | no |
| <a name="input_hadoop_config_path"></a> [hadoop\_config\_path](#input\_hadoop\_config\_path) | Path in root directory bucket to upload Hadoop config to | `string` | `"config/hadoop/conf/"` | no |
| <a name="input_hbase_config_path"></a> [hbase\_config\_path](#input\_hbase\_config\_path) | Path in root directory bucket to upload HBase config to | `string` | `"config/hbase/conf.dist/"` | no |
| <a name="input_master_bid_price"></a> [master\_bid\_price](#input\_master\_bid\_price) | Bid price for each EC2 instance in the master instance group, expressed in USD. By setting this attribute,<br>  the instance group is being declared as a Spot Instance, and will implicitly create a Spot request.<br>  Leave this blank to use On-Demand Instances | `string` | `""` | no |
| <a name="input_master_bid_price_as_percentage_of_on_demand_price"></a> [master\_bid\_price\_as\_percentage\_of\_on\_demand\_price](#input\_master\_bid\_price\_as\_percentage\_of\_on\_demand\_price) | Bid price as percentage of on-demand price for master instances | `number` | `100` | no |
| <a name="input_master_block_duration_minutes"></a> [master\_block\_duration\_minutes](#input\_master\_block\_duration\_minutes) | Duration for master spot instances, in minutes | `number` | `0` | no |
| <a name="input_master_ebs_size"></a> [master\_ebs\_size](#input\_master\_ebs\_size) | The volume size, in gibibytes (GiB). | `string` | `"100"` | no |
| <a name="input_master_ebs_type"></a> [master\_ebs\_type](#input\_master\_ebs\_type) | Type of volumes to attach to the master nodes. Valid options are gp2, io1, standard and st1 | `string` | `"gp2"` | no |
| <a name="input_master_ebs_volumes_count"></a> [master\_ebs\_volumes\_count](#input\_master\_ebs\_volumes\_count) | Number of volumes to attach to the master nodes | `number` | `1` | no |
| <a name="input_master_instance_fleet_name"></a> [master\_instance\_fleet\_name](#input\_master\_instance\_fleet\_name) | Name for the master instance fleet | `string` | `"MasterInstanceFleet"` | no |
| <a name="input_master_instance_on_demand_count"></a> [master\_instance\_on\_demand\_count](#input\_master\_instance\_on\_demand\_count) | Number of on-demand instances for the master instance fleet | `number` | `1` | no |
| <a name="input_master_instance_spot_count"></a> [master\_instance\_spot\_count](#input\_master\_instance\_spot\_count) | Number of spot instances for the master instance fleet | `number` | `0` | no |
| <a name="input_master_instance_type"></a> [master\_instance\_type](#input\_master\_instance\_type) | The EC2 instance type of the master nodes | `string` | `"m4.xlarge"` | no |
| <a name="input_master_timeout_action"></a> [master\_timeout\_action](#input\_master\_timeout\_action) | Timeout action for master instances | `string` | `"SWITCH_TO_ON_DEMAND"` | no |
| <a name="input_master_timeout_duration_minutes"></a> [master\_timeout\_duration\_minutes](#input\_master\_timeout\_duration\_minutes) | Spot provisioning timeout for master instances, in minutes | `number` | `10` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | ARN of the policy that will be used to set the permissions boundary for all IAM Roles created by this module | `string` | `null` | no |
| <a name="input_release_label"></a> [release\_label](#input\_release\_label) | The release label for the Amazon EMR release. | `string` | `"emr-5.29.0"` | no |
| <a name="input_require_abac_for_subnet"></a> [require\_abac\_for\_subnet](#input\_require\_abac\_for\_subnet) | If abac\_valid\_tags is specified, choose whether or not to require ABAC also for actions related to the subnet | `bool` | `true` | no |
| <a name="input_s3_policy_arns"></a> [s3\_policy\_arns](#input\_s3\_policy\_arns) | [DEPRECATED] List of policy ARNs to attach to EMR EC2 instance profile. Use 'additional\_policy\_arns' instead. | `list(string)` | `[]` | no |
| <a name="input_security_configuration"></a> [security\_configuration](#input\_security\_configuration) | The name of an EMR Security Configuration | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. Replaces `additional_tags`. | `map(string)` | `{}` | no |
| <a name="input_utility_script_bucket_key"></a> [utility\_script\_bucket\_key](#input\_utility\_script\_bucket\_key) | Key (i.e. path) to upload the utility script to | `string` | `"util/upload_hbase_config.sh"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_core_ebs_size"></a> [core\_ebs\_size](#output\_core\_ebs\_size) | The core EBS volume size, in gibibytes (GiB). |
| <a name="output_core_ebs_type"></a> [core\_ebs\_type](#output\_core\_ebs\_type) | The core EBS volume size, in gibibytes (GiB). |
| <a name="output_core_ebs_volumes_count"></a> [core\_ebs\_volumes\_count](#output\_core\_ebs\_volumes\_count) | Number of volumes to attach to the core nodes |
| <a name="output_core_fleet_instance_count"></a> [core\_fleet\_instance\_count](#output\_core\_fleet\_instance\_count) | Number of on-demand and spot core instances configured |
| <a name="output_core_instance_type"></a> [core\_instance\_type](#output\_core\_instance\_type) | The EC2 instance type of the core nodes |
| <a name="output_emr_configuration_json"></a> [emr\_configuration\_json](#output\_emr\_configuration\_json) | EMR cluster configuration in JSON format |
| <a name="output_emr_ec2_instance_profile_arn"></a> [emr\_ec2\_instance\_profile\_arn](#output\_emr\_ec2\_instance\_profile\_arn) | ARN of the EMR EC2 instance profile created |
| <a name="output_emr_ec2_instance_profile_name"></a> [emr\_ec2\_instance\_profile\_name](#output\_emr\_ec2\_instance\_profile\_name) | Name of the EMR EC2 instance profile created |
| <a name="output_emr_ec2_role_arn"></a> [emr\_ec2\_role\_arn](#output\_emr\_ec2\_role\_arn) | ARN of the EMR EC2 role created for EC2 instances |
| <a name="output_emr_managed_core_sg_ids"></a> [emr\_managed\_core\_sg\_ids](#output\_emr\_managed\_core\_sg\_ids) | List of security group ids of the EMR Core Security Group |
| <a name="output_emr_managed_master_sg_ids"></a> [emr\_managed\_master\_sg\_ids](#output\_emr\_managed\_master\_sg\_ids) | List of security group ids of the EMR Master Security Group |
| <a name="output_emr_managed_sg_id"></a> [emr\_managed\_sg\_id](#output\_emr\_managed\_sg\_id) | Security group id of the EMR Managed Security Group for internal communication |
| <a name="output_emr_service_access_sg_ids"></a> [emr\_service\_access\_sg\_ids](#output\_emr\_service\_access\_sg\_ids) | List of security group ids of the EMR Service Access Security Group |
| <a name="output_emr_service_role_arn"></a> [emr\_service\_role\_arn](#output\_emr\_service\_role\_arn) | ARN of the EMR service role created |
| <a name="output_emr_service_role_name"></a> [emr\_service\_role\_name](#output\_emr\_service\_role\_name) | Name of the EMR service role created |
| <a name="output_hbase_config_path"></a> [hbase\_config\_path](#output\_hbase\_config\_path) | Path in the root directory bucket that HBase config was uploaded to. |
| <a name="output_log_uri"></a> [log\_uri](#output\_log\_uri) | The path to the S3 location where logs for this cluster are stored. |
| <a name="output_master_ebs_size"></a> [master\_ebs\_size](#output\_master\_ebs\_size) | The master EBS volume size, in gibibytes (GiB). |
| <a name="output_master_ebs_type"></a> [master\_ebs\_type](#output\_master\_ebs\_type) | Type of volumes to attach to the master nodes. Valid options are gp2, io1, standard and st1 |
| <a name="output_master_ebs_volumes_count"></a> [master\_ebs\_volumes\_count](#output\_master\_ebs\_volumes\_count) | Number of volumes to attach to the master nodes |
| <a name="output_master_fleet_instance_count"></a> [master\_fleet\_instance\_count](#output\_master\_fleet\_instance\_count) | Number of on-demand and spot master instances configured |
| <a name="output_master_instance_type"></a> [master\_instance\_type](#output\_master\_instance\_type) | The EC2 instance type of the master nodes |
| <a name="output_release_label"></a> [release\_label](#output\_release\_label) | The release label for the Amazon EMR release. |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | ID of the subnet where EMR cluster was created |
| <a name="output_tamr_emr_cluster_id"></a> [tamr\_emr\_cluster\_id](#output\_tamr\_emr\_cluster\_id) | Identifier for the AWS EMR cluster created. Empty string if set up infrastructure for ephemeral cluster. |
| <a name="output_tamr_emr_cluster_name"></a> [tamr\_emr\_cluster\_name](#output\_tamr\_emr\_cluster\_name) | Name of the AWS EMR cluster created |
| <a name="output_upload_config_script_s3_key"></a> [upload\_config\_script\_s3\_key](#output\_upload\_config\_script\_s3\_key) | The name of the upload config script object in the bucket. |
<!-- END_TF_DOCS -->