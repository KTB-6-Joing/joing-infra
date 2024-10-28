resource "aws_ssm_parameter" "db_username" {
  name        = "/database/master/username"
  description = "Joing MySQL DB Username"
  type        = "SecureString"
  value       = var.db_master_username

  tags = {
    service = "joing MySQL RDS Username"
  }
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/database/master/password"
  description = "Joing MySQL DB Password"
  type        = "SecureString"
  value       = var.db_master_password

  tags = {
    service = "joing MySQL RDS Password"
  }
}