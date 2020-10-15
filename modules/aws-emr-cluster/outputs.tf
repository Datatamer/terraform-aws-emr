output "tamr_emr_cluster_id" {
  value       = var.create_static_cluster ? aws_emr_cluster.emr-cluster[0].id : ""
  description = "Identifier for the AWS EMR cluster created"
}
