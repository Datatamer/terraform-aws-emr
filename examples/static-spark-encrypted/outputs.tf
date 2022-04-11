output "logs-bucket" {
  value = module.emr-logs-bucket
}

output "rootdir-bucket" {
  value = module.emr-rootdir-bucket
}

output "cluster" {
  value = module.emr-spark
}
