output "tamr_emr_cluster_id" {
  value = aws_emr_cluster.emr-hbase.id
  description = "Identifier for the AWS EMR cluster created"
}
