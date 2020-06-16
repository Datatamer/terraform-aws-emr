output "emrfs_dynamodb_table_id" {
  value       = aws_dynamodb_table.emrfs_dynamodb_table.id
  description = "ID for the emrfs dynamodb table"
}

output "emrfs_dynamodb_table_name" {
  value       = aws_dynamodb_table.emrfs_dynamodb_table.name
  description = "Name for the emrfs dynamodb table"
}
