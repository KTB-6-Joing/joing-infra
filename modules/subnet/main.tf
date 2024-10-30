resource "aws_subnet" "eks_cluster" {
  count = length(var.eks_cluster_subnet)

  vpc_id            = var.vpc_id
  cidr_block        = element(var.eks_cluster_subnet, count.index)
  availability_zone = element(var.availability_zone_2, count.index)

  tags = {
    name       = "eks_cluster_subnet-${count.index + 1}"
    visibility = "public"
  }
}

resource "aws_subnet" "eks_node_group_subnet_medium" {
  count = length(var.eks_node_group_subnet_medium)

  vpc_id                  = var.vpc_id
  cidr_block              = element(var.eks_node_group_subnet_medium, count.index)
  availability_zone       = element(var.availability_zone_2, count.index)
  map_public_ip_on_launch = true

  tags = {
    name       = "eks_node_group_subnet-medium"
    visibility = "public"
    instance   = "medium"
    "kubernetes.io/role/elb" = 1
    "kubernetes.io/cluster/eks-default" = "owned"
  }
}

resource "aws_subnet" "eks_node_group_subnet_spot" {
  count = length(var.eks_node_group_subnet_spot)

  vpc_id                  = var.vpc_id
  cidr_block              = element(var.eks_node_group_subnet_spot, count.index)
  availability_zone       = element(var.availability_zone_2a, count.index)
  map_public_ip_on_launch = true

  tags = {
    name       = "eks_node_group_subnet-spot"
    visibility = "public"
    instance   = "spot"
  }
}

resource "aws_subnet" "rds_public" {
  count = length(var.rds_subnet_public)

  vpc_id            = var.vpc_id
  cidr_block        = element(var.rds_subnet_public, count.index)
  availability_zone = element(var.availability_zone_2, count.index)

  tags = {
    Name       = "eks_rds_subnet-${count.index + 1}"
    visibility = "public"
  }
}

resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = var.mysql_subnet_group_name
  subnet_ids = aws_subnet.rds_public[*].id

  tags = {
    Name = "RDS MySQL subnet group"
  }
}