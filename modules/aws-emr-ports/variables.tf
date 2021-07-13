variable "master_ports" {
  type        = list(number)
  description = "Ports used by AWS EMR Master"
  default = [
    80,
    2181,
    8020,
    8070,
    8085,
    8088,
    8443,
    9090,
    9095,
    16000,
    16010,
    16020,
    16030,
    18080,
    19888,
    20888,
    50070
  ]
}

variable "core_ports" {
  type = list(number)
  description = "Ports used by AWS EMR Core"
  default = [
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
