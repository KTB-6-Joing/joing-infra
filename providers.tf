terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.63.0"
    }
  }
  // default_tags 추가 -> product
}

provider "aws" {
  region = var.aws_region
}