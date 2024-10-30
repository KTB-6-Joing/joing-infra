variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-2"
}

variable "account_alias" {
  description = "Account alias"
  type        = string
  default     = "id"
}

variable "product" {
  description = "Product name"
  type        = string
  default     = "eks"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.31"
}

variable "release_version" {
  description = "EKS AMI release version"
  type        = string
  default     = "1.31.0-20241011"
}

variable "vpc_id" {
  description = "joing VPC ID"
  type        = string
}

variable "cluster_subnet_ids" {
  description = "EKS Cluster Subnet IDs"
  type        = list(string)
}

variable "node_group_subnet_ids" {
  description = "Node Group Subnet IDs"
  type        = list(list(string))
}

variable "enable_public_access" {
  description = "Enable public API server endpoint"
  type        = bool
  default     = true
}

variable "coredns_version" {
  description = "CoreDNS addon version"
  type        = string
  default     = "v1.11.3-eksbuild.1"
}

variable "kube_proxy_version" {
  description = "kube-proxy addon version"
  type        = string
  default     = "v1.31.0-eksbuild.5"
}

variable "vpc_cni_version" {
  description = "VPC CNI addon version"
  type        = string
  default     = "v1.18.5-eksbuild.1"
}

variable "pod_identity_agent_version" {
  description = "Pod Identity Agent addon version"
  type        = string
  default     = "v1.3.2-eksbuild.2"
}

/*
variable "ebs_csi_driver_version" {
  description = "EBS CSI driver addon version"
  type        = string
  default     = "v1.36.0-eksbuild.1"
}
*/

/* fargate block --> 미사용 결정
variable "fargate_enabled" {
  description = "Enable Fargate profile"
  type        = bool
  default     = false
}

variable "fargate_profile_name" {
  description = "Fargate profile name"
  type        = string
  default     = ""
}
*/

/*
  nodeGroup block
  Need to modify detailed specifications 
*/
variable "node_group_configurations" {
  description = "List of node group configurations"
  type = list(object({
    name                = string
    spot_enabled        = bool
    release_version     = string
    disk_size           = number
    ami_type            = string
    node_instance_types = list(string)
    node_min_size       = number
    node_desired_size   = number
    node_max_size       = number
    labels              = map(string)
  }))
  default = [
    {
      name                = "ondemand_medium"
      spot_enabled        = false
      release_version     = "1.31.0-20241011"
      disk_size           = 20
      ami_type            = "AL2023_x86_64_STANDARD"
      node_instance_types = ["t3.medium"]
      node_min_size       = 2
      node_desired_size   = 2
      node_max_size       = 2 // 온디맨드 고정
      labels = {
        "cpu_chip"  = "intel"
        "node-type" = "ondemand"
      }
    },
    {
      name                = "spot_medium"
      spot_enabled        = true
      disk_size           = 20
      release_version     = "1.31.0-20241011"
      ami_type            = "AL2023_x86_64_STANDARD"
      node_instance_types = ["t3.medium"]
      node_min_size       = 0
      node_desired_size   = 0
      node_max_size       = 2 // 최대 2개까지 스케일아웃.
      labels = {
        "cpu_chip"  = "intel"
        "node-type" = "spot"
        "jenkins"   = "true"
      },
    }
  ]
}

variable "additional_security_group_ingress" {
  description = "Additional security group ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

// Need to modify specifications
variable "aws_auth_master_users_arn" {
  description = "List of user ARNs to configure in aws-auth configmap"
  type        = list(string)
  default     = ["arn:aws:iam::054037113048:user/cloud-ethan"]
}

variable "aws_auth_master_roles_arn" {
  description = "List of role ARNs to configure in aws-auth configmap"
  type        = list(string)
  default     = []
}

variable "aws_auth_viewer_roles_arn" {
  description = "List of viewer role ARNs to configure in aws-auth configmap"
  type        = list(string)
  default     = []
}

/*
  KMS, SSM, secretManager block
  Need to modify detailed specifications
*/
variable "external_secrets_access_kms_arns" {
  description = "List of KMS ARNs that External Secrets can access"
  type        = list(string)
  default     = ["*"]
}

variable "external_secrets_access_ssm_arns" {
  description = "List of SSM ARNs that External Secrets can access"
  type        = list(string)
  default     = ["*"]
}

variable "external_secrets_access_secretsmanager_arns" {
  description = "List of Secrets Manager ARNs that External Secrets can access"
  type        = list(string)
  default     = ["*"]
}