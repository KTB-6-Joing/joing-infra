variable "vpc_id" {
  type        = string
  description = "joing VPC ID"
}

variable "subnet_group_name" {
  type        = string
  description = "joing MySQL DB Subnet Group Name"
}

variable "settings" {
  type = map(any)
  default = {
    "engine_version" = "8.0.39",
    "instance_class" = "t3.micro"
  }
  description = "RDS Instance Settings"
}

variable "db_master_username" {
  type        = string
  description = "DB Master Username"
  default     = "test" // for tf validate -- 삭제 예정
}

variable "db_master_password" {
  type        = string
  description = "DB Master Password"
  default     = "test" // for tf validate -- 삭제 예정
}