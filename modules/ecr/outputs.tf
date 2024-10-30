output "repository_urls" {
  description = "Map of repository names to URLs"
  value = {
    for name, repo in aws_ecr_repository.repositories : name => repo.repository_url
  }
}

output "repository_arns" {
  description = "Map of repository names to ARNs"
  value = {
    for name, repo in aws_ecr_repository.repositories : name => repo.arn
  }
}

output "registry_ids" {
  description = "Map of repository names to registry IDs"
  value = {
    for name, repo in aws_ecr_repository.repositories : name => repo.registry_id
  }
}

output "repository_names" {
  description = "Map of repository keys to their actual repository names"
  value = {
    for name, repo in aws_ecr_repository.repositories : name => repo.name
  }
}

output "repositories" {
  description = "Map containing all repository details including URLs, ARNs, and registry IDs"
  value = {
    for name, repo in aws_ecr_repository.repositories : name => {
      url         = repo.repository_url
      arn         = repo.arn
      registry_id = repo.registry_id
      name        = repo.name
    }
  }
}