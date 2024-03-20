terraform {
  required_version = ">= 0.13"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.0.0"
    }
  }
}
