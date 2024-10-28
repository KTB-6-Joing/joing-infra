resource "aws_ecr_repository" "main" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.kms_key
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = var.tags
}

# ECR Repository Policy
resource "aws_ecr_repository_policy" "main" {
  repository = aws_ecr_repository.main.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowPull"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
        Condition = {
          StringEquals = {
            "aws:PrincipalOrgID" : data.aws_organizations_organization.current.id
          }
        }
      }
    ]
  })
}

# Lifecycle Policy
resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules = concat([
      {
        rulePriority = 1
        description  = "Expire untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = var.lifecycle_policy.untagged_image_expiration_days
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Keep only recent images except protected tags"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = var.lifecycle_policy.protected_tags
          countType     = "imageCountMoreThan"
          countNumber   = var.lifecycle_policy.max_image_count
        }
        action = {
          type = "expire"
        }
      }
    ])
  })
}

# Enable replication if needed
resource "aws_ecr_replication_configuration" "main" {
  count = length(var.replication_regions) > 0 ? 1 : 0

  replication_configuration {
    rule {
      destination {
        dynamic "region" {
          for_each = var.replication_regions
          content {
            region      = region.value
            registry_id = data.aws_caller_identity.current.account_id
          }
        }
      }
    }
  }
}

# Data sources
data "aws_caller_identity" "current" {}            // Current AWS User Info for Terraform running
data "aws_organizations_organization" "current" {} // Current AWS Organizations Info
