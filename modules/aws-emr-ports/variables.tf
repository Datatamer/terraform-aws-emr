variable "master_ports_emr" {
  type        = list(number)
  description = "Ports used by AWS EMR"
  default     = [
    8443
  ]
}

variable "master_ports_spark" {
  type        = list(number)
  description = "Ports used by Spark"
  default     = [
    8088,
    18080,
    19888,
    20888
  ]
}

variable "master_ports_hbase" {
  type        = list(number)
  description = "Ports used by HBase"
  default     = [
    2181,
    8020,
    8070,
    8085,
    9090,
    9095,
    16000,
    16010,
    16020,
    16030,
    50070
  ]
}

variable "master_ports_ganglia" {
  type        = list(number)
  description = "Ports used by Ganglia"
  default     = [
    80
  ]
}

variable "core_ports" {
  type        = list(number)
  description = "Ports used by AWS EMR Core"
  default     = [
    8042,
    50010,
    50075
  ]
}

variable "additional_ports" {
  type        = list(number)
  description = "Additional ports to add to the output of this module"
  default     = []
}

variable "applications" {
  type        = list(string)
  description = "List of applications to run on EMR"
}
