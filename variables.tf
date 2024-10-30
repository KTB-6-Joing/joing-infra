variable "aws_region" {
  default = "ap-northeast-2"
}

variable "db_master_username" {
  type        = string
  sensitive   = true
  description = "Joing MySQL RDS Username"
}

variable "db_master_password" {
  type        = string
  sensitive   = true
  description = "Joing MySQL RDS Password"
}