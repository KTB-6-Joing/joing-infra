output "eks_cluster" {
  value = aws_subnet.eks_cluster[*].id
}

output "eks_node_group" {
  value = concat(var.eks_node_group_subnet_public, var.eks_node_group_subnet_private)
}

output "eks_node_group_public" {
  value = aws_subnet.eks_node_group_public[*].id
}

output "eks_node_group_private" {
  value = aws_subnet.eks_node_group_private[*].id
}

output "rds_public" {
  value = aws_subnet.rds_public[*].id
}

output "mysql_subnet_group_name" {
  value = aws_db_subnet_group.mysql_subnet_group.name
}
