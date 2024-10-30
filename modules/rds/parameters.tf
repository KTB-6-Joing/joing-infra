resource "aws_ssm_parameter" "joing_mysql_endpoint" {
  name        = "/joing/db/mysql/database_endpoint"
  description = "Joing MySQL DB Endpoint"
  type        = "SecureString"
  value       = aws_db_instance.joing_mysql.endpoint

  tags = {
    service = "joing MySQL RDS Endpoint"
  }
}

resource "aws_ssm_parameter" "joing_mysql_username" {
  name        = "/joing/db/mysql/username"
  description = "Joing MySQL DB Username"
  type        = "SecureString"
  value       = var.db_master_username

  tags = {
    service = "joing MySQL RDS Username"
  }
}

resource "aws_ssm_parameter" "joing_mysql_password" {
  name        = "/joing/db/mysql/password"
  description = "Joing MySQL DB Password"
  type        = "SecureString"
  value       = var.db_master_password

  tags = {
    service = "joing MySQL RDS Password"
  }
}