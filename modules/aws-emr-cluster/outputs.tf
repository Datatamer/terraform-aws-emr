output "tamr_emr_cluster_id" {
  value       = var.create_static_cluster ? aws_emr_cluster.emr-cluster[0].id : ""
  description = "Identifier for the AWS EMR cluster created"
}

output "tamr_emr_cluster_name" {
  value       = var.create_static_cluster ? aws_emr_cluster.emr-cluster[0].name : ""
  description = "Name of the AWS EMR cluster created"
}
