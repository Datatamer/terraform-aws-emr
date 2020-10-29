output "logs-bucket" {
  value = module.emr-logs-bucket
}

output "rootdir-bucket" {
  value = module.emr-rootdir-bucket
}

output "sgs" {
  value = module.ephemeral-spark-sgs
}

output "iam" {
  value = module.ephemeral-spark-iam
}

output "config" {
  value = module.ephemeral-spark-config
}
