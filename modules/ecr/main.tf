// resource "aws_ecr_repository" "repository" {
//  for_each = var.repository_names

//  name                 = each.key
//  image_tag_mutability = var.image_tag_mutability