variable "master_ports_emr" {
  type        = list(number)
  description = "Ports used by AWS EMR"
  default = [
    8443 // EMR Cluster Manager
  ]
}

variable "master_ports_spark" {
  type        = list(number)
  description = "Ports used by AWS EMR Master Spark"
  default = [
    8088,  // Yarn Resource Manager
    18080, // Spark HistoryServer
    19888, // MapReduce JobHistory Server Webapp Port
    20888  // Yarn Resource Manager - Proxy
  ]
}

variable "is_pre_6x" {
  type        = bool
  description = "Is this a pre-6x EMR"
  default     = true
}

variable "master_ports_hbase_common" {
  type        = list(number)
  description = "Common ports used by AWS EMR Master HBase"
  default = [
    2181,  // Zookeeper client
    8020,  // HDFS RPC
    8070,  // REST server
    8085,  // REST UI
    9090,  // Thrift server
    9095,  // Thrift server UI
    16000, // Hbase Master
    16010  // Hbase Master UI
  ]
}

variable "master_ports_hbase_pre_6x" {
  type        = list(number)
  description = "Ports used by AWS EMR Master HBase pre-6.x"
  default = [
    50070 // HDFS NameNode
  ]
}

variable "master_ports_hbase_6x" {
  type        = list(number)
  description = "Ports used by AWS EMR Master HBase post-6.x"
  default = [
    9870 // HDFS NameNode
  ]
}

variable "master_ports_ganglia" {
  type        = list(number)
  description = "Ports used by Ganglia"
  default = [
    80 // HTTP port
  ]
}

variable "core_ports_emr_pre_6x" {
  type        = list(number)
  description = "Ports used by AWS EMR Core pre-6x"
  default = [
    50010, // HDFS DataNode 2
    50075  // HDFS DataNode 1
  ]
}

variable "core_ports_emr_6x" {
  type        = list(number)
  description = "Ports used by AWS EMR Core 6x"
  default = [
    9864 // HDFS DataNode
  ]
}

variable "core_ports_spark" {
  type        = list(number)
  description = "Ports used by AWS EMR Core Spark"
  default = [
    8042 // YARN NodeManager
  ]
}

variable "core_ports_hbase" {
  type        = list(number)
  description = "Ports used by AWS EMR Core HBase"
  default = [
    16020, // RegionServer
    16030  // RegionServer Info
  ]
}

variable "service_access_ports" {
  type        = list(number)
  description = "Ports used by AWS Service Access"
  default = [
    22,  // SSH Access
    9443 // HTTPS Access
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
