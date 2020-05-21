# Tamr AWS EMR HBase Terraform Module
This terraform module creates an Apache HBase cluster on Amazon EMR.

# Example
main.tf:
```
module "emr_hbase_module" {
  source = "git::git@github.com:Datatamer/terraform-emr-hbase.git//modules/aws-emr-hbase?ref=0.3.0"
  name = "example-hbase-cluster"
  subnet_id = "subnet-examplesubnet"
  emr_managed_master_security_group = "sg-examplesg1"
  additional_master_security_groups = "sg-examplesg2"
  emr_managed_slave_security_group = "sg-examplesg3"
  additional_slave_security_groups = "sg-examplesg4"
  service_access_security_group = "sg-examplesg5"
  instance_profile = "arn:aws:iam::123456789098:instance-profile/example_emr_instance_profile"
  service_role = "arn:aws:iam::123456789098:role/example_emr_service_role"
  key_name = "exampleKeyPair"
  emr_hbase_s3_bucket_logs = "emr-hbase-logs-example"
  emr_hbase_s3_bucket_root_dir = "emr-hbase-rootdir-example"
  path_to_config_file = "path/to/config/file"
}
```

# Resources Created
This terraform module creates:
* 1 AWS EMR Cluster with Apache Hbase application installed. 

# Variables
## Inputs
* `subnet_id` (required): VPC subnet id where you want the job flow to launch
* `emr_managed_master_security_group` (required): Identifier of the Amazon EC2 EMR-Managed security group for the master node
* `additional_master_security_groups` (required): String containing a comma separated list of additional Amazon EC2 security group IDs for the master node
* `emr_managed_slave_security_group` (required): Identifier of the Amazon EC2 EMR-Managed security group for the slave nodes
* `additional_slave_security_groups` (required): String containing a comma separated list of additional Amazon EC2 security group IDs for the slave nodes as a comma separated string
* `service_access_security_group` (required): Identifier of the Amazon EC2 service-access security group - required when the cluster runs on a private subnet
* `instance_profile` (required): ARN of the Instance Profile for EC2 instances of the cluster assume this role
* `service_role` (required): ARN of the service role for the EMR cluster
* `key_name` (required): Amazon EC2 key pair that can be used to ssh to the master node as the user called hadoop
* `emr_hbase_s3_bucket_logs` (required): Name of the S3 bucket for EMR logs
* `emr_hbase_s3_bucket_root_dir` (required): Name of the S3 bucket used as EMR Hbase root directory
* `path_to_config_file` (required): Path to the EMR Hbase config file. Include filename too.
* `name` (optional): Name of EMR HBase cluster
* `master_instance_group_name` (optional): Name to be given to the instance group for Master instances.
* `core_instance_group_name` (optional): Name to be given to the instance group for the core/slave/worker/agent instances.
* `release_label` (optional): The release label for the Amazon EMR release.
* `instance_type` (optional): The EC2 instance type of the master and slave nodes
* `master_group_instance_count` (optional): Number of instances for the master instance group. Must be 1 or 3.
* `core_group_instance_count` (optional): Number of Amazon EC2 instances used to execute the job flow
* `tags` (optional): Additional tags for the cluster
* `emrfs_metadata_table_name` (optional): EMRFS metadata table name in Dynamodb
* `emrfs_metadata_read_capacity` (optional): Read capacity units of the Dynamodb table used for EMRFS metadata
* `emrfs_metadata_write_capacity` (optional): Write capacity units of the Dynamodb table used for EMRFS metadata

## Outputs
* `tamr_emr_cluster_id`: Identifier for the AWS EMR cluster created

# Reference documents:
* AWS EMR HBase: https://aws.amazon.com/emr/features/hbase/
* AWS EMR Cluster Terraform Docs: https://www.terraform.io/docs/providers/aws/r/emr_cluster.html
* Terraform module structure: https://www.terraform.io/docs/modules/index.html#standard-module-structure

