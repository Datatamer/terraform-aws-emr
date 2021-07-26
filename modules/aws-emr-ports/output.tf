locals {
  applications          = [for app in var.applications : lower(app)]
  running_hbase         = contains(local.applications, "hbase")
  running_spark         = contains(local.applications, "spark")
  running_ganglia       = contains(local.applications, "ganglia")
  output_hbase_core     = local.running_hbase ? var.core_ports_hbase : []
  output_spark_core     = local.running_spark ? var.core_ports_spark : []
  output_hbase_master   = local.running_hbase ? var.master_ports_hbase : []
  output_spark_master   = local.running_spark ? var.master_ports_spark : []
  output_ganglia_master = local.running_ganglia ? var.master_ports_ganglia : []
}

output "ingress_master_ports" {
  value = flatten(
    setunion(
      local.output_hbase_master,
      local.output_spark_master,
      local.output_ganglia_master,
      var.master_ports_emr,
      var.additional_ports
  ))
  description = "List of ingress master ports"
}

output "ingress_core_ports" {
  value = flatten(
    setunion(
      local.output_hbase_core,
      local.output_spark_core,
      var.core_ports_emr,
      var.additional_ports
  ))
  description = "List of ingress core ports"
}

output "ingress_service_access_ports" {
  value       = var.service_access_ports
  description = "List of service access ports"
}
