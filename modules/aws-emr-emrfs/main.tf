#
# EMRFS DynamoDB Table
#

resource "aws_dynamodb_table" "emrfs_dynamodb_table" {
  name           = var.emrfs_metadata_table_name
  read_capacity  = var.emrfs_metadata_read_capacity
  write_capacity = var.emrfs_metadata_write_capacity
  hash_key       = "hashKey"
  range_key      = "rangeKey"

  attribute {
    name = "hashKey"
    type = "S"
  }

  attribute {
    name = "rangeKey"
    type = "S"
  }

  tags = var.tags
}

resource "time_static" "current_time" {}

resource "aws_dynamodb_table_item" "test_item" {
  table_name = aws_dynamodb_table.emrfs_dynamodb_table.name
  hash_key   = aws_dynamodb_table.emrfs_dynamodb_table.hash_key
  range_key  = aws_dynamodb_table.emrfs_dynamodb_table.range_key
  item       = <<ITEM
{
  "hashKey": {"S": "MultiKeyStoreTag"},
  "rangeKey": {"S": "TableRole"},
  "counter": {"N": "1"},
  "deletionTTL": {"N": "0"},
  "lastModified": {"N": "${time_static.current_time.unix}"},
  "payload": {"B": "AA=="}
}
ITEM
}
