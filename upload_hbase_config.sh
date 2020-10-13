#!/bin/bash
set -e

app=$1

if [[ $app == 'hbase' ]]; then
    # Sync contents of /etc/hbase/conf.dist directory to s3
    aws s3 sync /etc/hbase/conf.dist/ s3://${bucket_name_for_root_directory}/${hbase_config_path} --sse AES256
fi

# Sync contents of /etc/hadoop/conf directory to s3
aws s3 sync /etc/hadoop/conf/ s3://${bucket_name_for_root_directory}/${hadoop_config_path} --sse AES256
