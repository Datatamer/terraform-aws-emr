output "emrfs_dynamodb_table_id" {
  value       = var.create_static_cluster ? aws_dynamodb_table.emrfs_dynamodb_table[0].id : ""
  description = "ID for the emrfs dynamodb table"
}

output "emrfs_dynamodb_table_name" {
  value       = var.create_static_cluster ? aws_dynamodb_table.emrfs_dynamodb_table[0].name : ""
  description = "Name for the emrfs dynamodb table"
}
