locals {
  dynamodb = var.create_static_cluster && length(aws_dynamodb_table.emrfs_dynamodb_table) > 0
}

output "emrfs_dynamodb_table_id" {
  value       = local.dynamodb ? aws_dynamodb_table.emrfs_dynamodb_table[0].id : ""
  description = "ID for the emrfs dynamodb table"
}

output "emrfs_dynamodb_table_name" {
  value       = local.dynamodb ? aws_dynamodb_table.emrfs_dynamodb_table[0].name : ""
  description = "Name for the emrfs dynamodb table"
}
