output "eks_cluster" {
  value = aws_subnet.eks_cluster[*].id
}

output "eks_node_group_subnet_spot" {
  value = aws_subnet.eks_node_group_subnet_spot[*].id
}

output "eks_node_group_subnet_ondemand" {
  value = aws_subnet.eks_node_group_subnet_ondemand[*].id
}

output "rds_public" {
  value = aws_subnet.rds_public[*].id
}

output "ec2_public" {
  value = aws_subnet.ec2_public.id
}

output "mysql_subnet_group_name" {
  value = aws_db_subnet_group.mysql_subnet_group.name
}

output "node_group_subnet_ids" {
  value = [
    aws_subnet.eks_node_group_subnet_ondemand[*].id,
    aws_subnet.eks_node_group_subnet_spot[*].id,
  ]
}