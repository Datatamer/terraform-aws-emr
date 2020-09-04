#!/bin/bash
set -e

# Sync contents of /etc/hbase/conf.dist directory to s3
aws s3 sync /etc/hbase/conf.dist/ s3://${emr_hbase_s3_bucket_root_dir}/${hbase_config_path}

# Sync contents of /etc/hadoop/conf directory to s3
aws s3 sync /etc/hadoop/conf/ s3://${emr_hbase_s3_bucket_root_dir}/${hadoop_config_path}
