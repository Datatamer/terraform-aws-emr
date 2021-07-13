output "ingress_master_ports" {
  value = concat(
  var.master_ports,
  var.additional_ports,
  )
  description = "List of ingress master ports"
}

output "ingress_core_ports" {
  value = concat(
  var.core_ports,
  var.additional_ports,
  )
  description = "List of ingress core ports"
}
