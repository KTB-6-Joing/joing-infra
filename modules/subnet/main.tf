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

resource "aws_subnet" "eks_node_group_subnet_ondemand" {
  count = length(var.eks_node_group_subnet_ondemand)

  vpc_id                  = var.vpc_id
  cidr_block              = element(var.eks_node_group_subnet_ondemand, count.index)
  availability_zone       = element(var.availability_zone_2, count.index)
  map_public_ip_on_launch = true

  tags = {
    name                                = "eks_node_group_subnet-ondemand"
    visibility                          = "public"
    instance                            = "large"
    "kubernetes.io/role/elb"            = 1
    "kubernetes.io/cluster/eks-default" = "owned"
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

resource "aws_subnet" "ec2_public" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.ec2_subnet_public
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true

  tags = {
    Name       = "eks_ec2_subnet-public"
    visibility = "public"
  }
}