bucket_name_for_logs = "tamr-emr-hbase-logs-dev"
bucket_name_for_hbase_root_dir = "tamr-emr-hbase-root-dir-dev"
aws_account_id = "825693534638"
vpc_id = "vpc-09186b4fd7031cf87"
key_pair_name = "tamr-emr-dev"
subnet_id = "subnet-0a6dce24beba1d027"
cluster_name = "emr-hbase-cluster-for-tamr-test"
emr_hbase_config_file_path = "../modules/aws-emr-hbase/config.json"
tamr_cidrs = [
  "10.142.0.0/20",
  "10.30.0.12/32",
]
emrfs_metadata_table_name = "EmrFSMetadata-dev"
