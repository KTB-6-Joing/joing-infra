variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-2"
}

variable "product" {
  description = "Product name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
}

variable "release_version" {
  description = "EKS AMI release version"
  type        = string
}

variable "vpc_id" { // uno
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" { // uno
  description = "Subnet IDs"
  type        = list(string)
}

variable "service_ipv4_cidr" { // uno
  description = "Service IPv4 CIDR for the Kubernetes cluster"
  type        = string
}

variable "enable_public_access" {
  description = "Enable public API server endpoint"
  type        = bool
  default     = true
}

variable "coredns_version" {
  description = "CoreDNS addon version"
  type        = string
}

variable "kube_proxy_version" {
  description = "kube-proxy addon version"
  type        = string
}

variable "vpc_cni_version" {
  description = "VPC CNI addon version"
  type        = string
}

variable "ebs_csi_driver_version" {
  description = "EBS CSI driver addon version"
  type        = string
}

variable "pod_identity_agent_version" {
  description = "Pod Identity Agent addon version"
  type        = string
}

/*
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

variable "node_group_configurations" { // spec - 비용 고민
  description = "List of node group configurations"
  type = list(object({
    name                = string
    spot_enabled        = bool
    release_version     = string
    disk_size          = number
    ami_type           = string
    node_instance_types = list(string)
    node_min_size      = number
    node_desired_size  = number
    node_max_size      = number
    labels             = map(string)
  }))
}

variable "additional_security_group_ingress" {
  description = "Additional security group ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "aws_auth_master_users_arn" {
  description = "List of user ARNs to configure in aws-auth configmap"
  type        = list(string)
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

variable "external_secrets_access_kms_arns" {
  description = "List of KMS ARNs that External Secrets can access"
  type        = list(string)
}

variable "external_secrets_access_ssm_arns" {
  description = "List of SSM ARNs that External Secrets can access"
  type        = list(string)
}

variable "external_secrets_access_secretsmanager_arns" {
  description = "List of Secrets Manager ARNs that External Secrets can access"
  type        = list(string)
}