#! /bin/bash
# This script creates and exports hbase snapshots to another cluster
# Run this script on the master node of HBase 1x cluster
# Usage: ./export-snapshot.sh <path/to/root/dir>
#         <path/to/root/dir> should be what hbase.rootdir is set to

# Parse the argument
if [ -z "$1" ] || [ "$1" == '-h' ]; then
  echo "Usage: $0 <path/to/hbase-rootdir>"
  echo "<path/to/root/dir> should be what hbase.rootdir is set to"
  exit 1
fi

# Set current time
time=$(date +'%Y%m%d-%H%M%S')

# List all tables and create snapshots
echo "list" | hbase shell -n | sed -e '1,/seconds/ d' |
  while IFS='' read -r tableName || [[ -n "$tableName" ]]; do
    if [[ $tableName =~ ^\s*$ ]]; then
      continue
    fi
    # Create snapshot of each table
    echo "snapshot '${tableName}', '${time}_${tableName#*:}'" | hbase shell -n &&
      echo "Snapshot created: ${time}_${tableName#*:}"
  done

# Export snapshots to another cluster
echo "list_snapshots" | hbase shell -n | sed '1,/seconds/ d' | grep $time
  while IFS='' read -r snapshotName || [[ -n "$snapshotName" ]]; do
    hbase org.apache.hadoop.hbase.snapshot.ExportSnapshot -snapshot "${snapshotName}" -copy-to "$1" -mappers 16
    status_code=$?$()
    if [ ${status_code} -ne 0 ]; then
      echo "Snapshot ${snapshotName} could not be exported: $status_code"
    else
      echo "Snapshot ${snapshotName} exported to $1"
    fi
  done
