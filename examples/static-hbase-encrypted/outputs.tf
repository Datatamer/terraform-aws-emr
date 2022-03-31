output "logs-bucket" {
  value = module.emr-logs-bucket
}

output "rootdir-bucket" {
  value = module.emr-rootdir-bucket
}

output "cluster" {
  value = module.emr-hbase
}

output "ec2-key" {
  value = module.emr_key_pair
}

output "private-key" {
  value     = tls_private_key.emr_private_key.private_key_pem
  sensitive = true
}

output "kms-key" {
  value = local.effective_kms_key_arn
}
