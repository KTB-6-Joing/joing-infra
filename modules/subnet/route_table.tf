resource "aws_route_table_association" "eks_cluster" {
  count          = length(var.eks_cluster_subnet)
  subnet_id      = aws_subnet.eks_cluster[count.index].id
  route_table_id = var.igw_rtb_id
}

resource "aws_route_table_association" "eks_node_group_subnet_medium" {
  count          = length(var.eks_node_group_subnet_medium)
  subnet_id      = aws_subnet.eks_node_group_subnet_medium[count.index].id
  route_table_id = var.igw_rtb_id
}

resource "aws_route_table_association" "eks_node_group_subnet_spot" {
  count          = length(var.eks_node_group_subnet_spot)
  subnet_id      = aws_subnet.eks_node_group_subnet_spot[count.index].id
  route_table_id = var.igw_rtb_id
}

resource "aws_route_table_association" "rds_public" {
  count          = length(var.rds_subnet_public)
  subnet_id      = aws_subnet.rds_public[count.index].id
  route_table_id = var.igw_rtb_id
}

resource "aws_route_table_association" "ec2_public" {
  subnet_id      = aws_subnet.ec2_public.id
  route_table_id = var.igw_rtb_id
}