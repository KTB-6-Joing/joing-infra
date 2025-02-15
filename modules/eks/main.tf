/*
# 현재 계정 정보 조회
data "aws_caller_identity" "current" {} // 추후에 활용하지 않으면 삭제 
*/

# EKS 클러스터 생성
resource "aws_eks_cluster" "main" {
  name     = "${var.product}-${terraform.workspace}"
  version  = var.cluster_version
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids              = var.cluster_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = var.enable_public_access
    security_group_ids      = [aws_security_group.cluster.id]
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator"]

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_service_policy,
  ]
  tags = {
    "alpha.eksctl.io/cluster-oidc-enabled" = "true"
  }
}

# 노드 그룹 생성
resource "aws_eks_node_group" "main" {
  // for_each = { for idx, config in var.node_group_configurations : config.name => config }
  for_each = { for idx, config in var.node_group_configurations : idx => config }

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = each.value.name
  node_role_arn   = aws_iam_role.eks_node_group.arn
  subnet_ids      = var.node_group_subnet_ids[each.key]

  ami_type        = each.value.ami_type
  capacity_type   = each.value.spot_enabled ? "SPOT" : "ON_DEMAND"
  instance_types  = each.value.node_instance_types
  disk_size       = each.value.disk_size
  release_version = each.value.release_version

  scaling_config {
    desired_size = each.value.node_desired_size
    max_size     = each.value.node_max_size
    min_size     = each.value.node_min_size
  }

  labels = merge(
    each.value.labels,
    {
      "nodegroup"    = each.value.name
      "capacityType" = each.value.spot_enabled ? "SPOT" : "ON_DEMAND"
    }
  )

  # 스팟 인스턴스에 대한 테인트 설정
  #  dynamic "taint" {
  #    for_each = each.value.jenkins_enabled ? [1] : []
  #    content {
  #      key    = "jenkins"
  #      value  = "true"
  #      effect = "NO_SCHEDULE"
  #    }
  #  }

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
  addon_version               = var.coredns_version
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "kube-proxy"
  addon_version               = var.kube_proxy_version
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "vpc-cni"
  addon_version               = var.vpc_cni_version
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "eks-pod-identity-agent"
  addon_version               = var.pod_identity_agent_version
  resolve_conflicts_on_update = "OVERWRITE"
}

/*
resource "aws_eks_addon" "ebs_csi" { // 확인 필요
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = var.ebs_csi_driver_version
  resolve_conflicts_on_update = "OVERWRITE"
}
*/