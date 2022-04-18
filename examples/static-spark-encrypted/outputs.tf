output "logs-bucket" {
  value       = module.emr-logs-bucket
  description = "S3 bucket where EMR cluster logs objects are stored."
}

output "rootdir-bucket" {
  value       = module.emr-rootdir-bucket
  description = "S3 bucket where EMR cluster root objects are stored."
}

output "cluster" {
  value       = module.emr-spark
  description = "EMR Cluster output information."
}
