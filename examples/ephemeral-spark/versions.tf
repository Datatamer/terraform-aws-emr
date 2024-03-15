terraform {
  required_version = ">= 0.13"
  required_providers {
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
