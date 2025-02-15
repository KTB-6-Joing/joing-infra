variable "vpc_id" {
  type        = string
  description = "joing VPC ID"
}

variable "public_subnet" {
  type        = string
  description = "joing public stubnet ids"
}

variable "settings" {
  type = map(any)
  default = {
    "ami"         = "ami-040c33c6a51fd5d96"
    "type"        = "t2.micro"
    "count"       = 1
    "key_name"    = "joing"
    "volume_size" = 10
  }
  description = "Test Server Instance Settings"
}

