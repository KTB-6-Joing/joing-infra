// 모듈 폴더 선언만 존재하게 작성

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "repository" {
  for_each = var.repository_names

  name                 = each.key
  image_tag_mutability = var.image_tag_mutability