variable "vpc_id" {
  type        = string
  description = "joing VPC ID"
}

variable "igw_rtb_id" {
  type        = string
  description = "joing Internet Gateway ID"
}

variable "mysql_subnet_group_name" {
  default = "rds-mysql-subent-group"
  description = "RDS MySQL Subnet Group Name" 
}

variable "eks_cluster_subnet" {
  type = list(string)

  default = [
    "192.168.96.0/28",
    "192.168.96.16/28",
  ]
  description = "EKS Cluster Subnets - public"

  validation {
    condition = length(var.eks_cluster_subnet) == 2
    error_message = "The length of eks_cluster_subnet must be equal to 2"
  }
}

variable "eks_node_group_subnet_public" {
  type = list(string)
  
  default = [
    "192.168.32.0/24",
    "192.168.33.0/24",
  ]
  description = "EKS NodeGroup Subnets - public"

  validation {
    condition = length(var.eks_node_group_subnet_public) == 2
    error_message = "The length of eks_node_group_subnet_public must be equal to 2"
  }
}

variable "eks_node_group_subnet_private" {
  type = list(string)
  
  default = [
    "192.168.160.0/24",
    "192.168.161.0/24",
  ]
  description = "EKS NodeGroup Subnets - private"

  validation {
    condition = length(var.eks_node_group_subnet_private) == 2
    error_message = "The length of eks_node_group_subnet_private must be equal to 2"
  }
}

variable "rds_subnet_public" {
  type = list(string)
  
  default = [
    "192.168.34.0/24",
    "192.168.35.0/24",
  ]
  description = "RDS Subnets - public"

  validation {
    condition = length(var.rds_subnet_public) == 2
    error_message = "The length of rds_subnet_public must be equal to 2"
  }
}

variable "availability_zone_2" {
  type = list(string)

  default = [
    "ap-northeast-2a", 
    "ap-northeast-2c",
  ]
  description = "2 Availability Zones"

  validation {
    condition = length(var.availability_zone_2) == 2
    error_message = "The length of availability_zone_2 must be equal to 2"
  }
}

variable "availability_zone_4" {
  type = list(string)

  default = [
    "ap-northeast-2a", 
    "ap-northeast-2b", 
    "ap-northeast-2c", 
    "ap-northeast-2d",
  ]
  description = "4 Availability Zones"

  validation {
    condition = length(var.availability_zone_4) == 4
    error_message = "The length of availability_zone_4 must be equal to 4"
  }
}

// 192.168.0.0/17 public | 192.168.128.0/17 private
