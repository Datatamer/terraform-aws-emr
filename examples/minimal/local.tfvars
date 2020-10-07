create_static_cluster          = true
applications                   = ["Hbase"]
bucket_name_for_logs           = "example-emr-hbase-logs"
bucket_name_for_root_directory = "example-emr-hbase-root-dir"
vpc_id                         = "vpc-examplevpc"
key_pair_name                  = "example-key-pair"
subnet_id                      = "subnet-examplesubnet"
cluster_name                   = "example-emr-hbase-cluster"
emr_config_file_path           = "path/to/config/file"
tamr_cidrs = [
  "1.2.3.4/32"
]
emrfs_metadata_table_name = "example-emrfs-table"
additional_tags = {
  tag1 = "value1",
  tag2 = "value2"
}
