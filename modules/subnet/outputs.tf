output "eks_cluster" {
  value = aws_subnet.eks_cluster[*].id
}

output "eks_node_group_subnet_medium" {
  value = [
    aws_subnet.eks_node_group_subnet_medium[*].id
  ]
}

output "eks_node_group_subnet_spot" {
  value = aws_subnet.eks_node_group_subnet_spot[*].id
}

output "rds_public" {
  value = aws_subnet.rds_public[*].id
}

output "mysql_subnet_group_name" {
  value = aws_db_subnet_group.mysql_subnet_group.name
}

output "node_group_subnet_ids" {
  value = [
    aws_subnet.eks_node_group_subnet_medium[*].id,
    aws_subnet.eks_node_group_subnet_spot[*].id,
  ]
}