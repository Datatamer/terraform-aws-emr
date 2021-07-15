locals {
  applications  = [for app in var.applications : lower(app)]
  running_hbase = contains(local.applications, "hbase")
  running_spark = contains(local.applications, "spark")
  output_hbase  = concat(var.master_ports_emr, var.master_ports_hbase, var.master_ports_ganglia, var.additional_ports)
  output_spark  = concat(var.master_ports_emr, var.master_ports_spark, var.additional_ports)
  output        = concat(var.master_ports_emr, var.additional_ports)
}

output "ingress_master_ports" {
  value = local.running_hbase ? local.output_hbase : (local.running_spark ? local.output_spark : local.output)
  description = "List of ingress master ports"
}

output "ingress_core_ports" {
  value = concat(
  var.core_ports,
  var.additional_ports,
  )
  description = "List of ingress core ports"
}
