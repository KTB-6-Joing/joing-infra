provider "aws" {
  region = var.aws_region

  default_tags { // providers.tf에 추가
    tags = {
      Environment = terraform.workspace
      Product     = var.product // providers.tf 에 추가 후 고민
      Terraform   = "true"
    }
  }
}

# 현재 계정 정보 조회
data "aws_caller_identity" "current" {} // 추후에 활용하지 않으면 삭제 

# EKS 클러스터 생성
resource "aws_eks_cluster" "main" {
  name     = "${var.product}-${terraform.workspace}"
  version  = var.cluster_version // default 추가
  role_arn = aws_iam_role.eks_cluster.arn // iam 추가

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = var.enable_public_access  // true
    security_group_ids      = [aws_security_group.cluster.id]
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.service_ipv4_cidr  // 
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_service_policy,
  ]
}

# 노드 그룹 생성
resource "aws_eks_node_group" "main" {
  for_each = { for idx, config in var.node_group_configurations : config.name => config }

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = each.value.name
  node_role_arn   = aws_iam_role.eks_node_group.arn
  subnet_ids      = var.subnet_ids

  ami_type       = each.value.ami_type
  capacity_type  = each.value.spot_enabled ? "SPOT" : "ON_DEMAND"
  instance_types = each.value.node_instance_types
  disk_size      = each.value.disk_size
  release_version = each.value.release_version

  scaling_config {
    desired_size = each.value.node_desired_size
    max_size     = each.value.node_max_size
    min_size     = each.value.node_min_size
  }

  labels = merge(
    each.value.labels,
    {
      "eks.amazonaws.com/nodegroup" = each.value.name
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_container_registry_policy,
  ]
}

# eks add-on
resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "coredns"
  addon_version              = var.coredns_version
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "kube-proxy"
  addon_version              = var.kube_proxy_version
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "vpc-cni"
  addon_version              = var.vpc_cni_version
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "ebs_csi" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version              = var.ebs_csi_driver_version
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "eks-pod-identity-agent"
  addon_version              = var.pod_identity_agent_version
  resolve_conflicts_on_update = "OVERWRITE"
}