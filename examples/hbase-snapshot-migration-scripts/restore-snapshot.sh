#! /bin/bash
# This script restores snapshots on the cluster
# Run this script on HBase 2x cluster
# Usage: ./restore-snapshot.sh

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
