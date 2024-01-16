terraform {
  required_version = ">= 0.12.26"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.0"
    }
  }
}

provider "aws" {
  region = var.region
}
