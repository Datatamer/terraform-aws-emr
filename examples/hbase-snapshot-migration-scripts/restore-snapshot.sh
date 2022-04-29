#! /bin/bash
# This script restores snapshots on the cluster
# Run this script on the master node of HBase 2x cluster
# Usage: ./restore-snapshot.sh <namespace>

# Parse the argument
if [ -z "$1" ] || [ "$1" == '-h' ]; then
  echo "Usage: $0 <namespace>"
  exit 1
fi

# Create the namespace for tables
mapfile -t arr < <(echo "list_namespace" | hbase shell -n | sed '2,${/seconds/d;}' | sed '2,${/row(s)/d;}' | sed '1d')
for i in "${arr[@]}"; do
  if [ "${arr[$i]}" == "$1" ]; then
    echo "Namespace ${arr[$i]} already exists"
  else
    echo "create_namespace '$1'" | hbase shell -n
    # Check if the namespace is created
    echo "list_namespace" | hbase shell -n
    break
  fi
done

# List snapshots and restore each snapshot
echo "list_snapshots" | hbase shell -n | sed '1,/seconds/ d' |
  while IFS='' read -r snapshotName || [[ -n "$snapshotName" ]]; do
    echo "restore_snapshot '${snapshotName}'" | hbase shell -n
    status_code=$?$()
    if [ ${status_code} -ne 0 ]; then
      echo "Snapshot ${snapshotName} could not be restored: $status_code"
    else
      # Check if the table is restored on the cluster
      echo "list" | hbase shell -n
    fi
  done
