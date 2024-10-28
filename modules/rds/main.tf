resource "aws_db_instance" "joing_mysql" {
  db_name                = "joing_mysql"
  identifier             = "joing"
  engine                 = "mysql"
  engine_version         = var.settings.engine_version // 정의 해야지
  instance_class         = var.settings.instance_class // 나중에 확인
  allocated_storage      = 20                          // 나중에 확인
  db_subnet_group_name   = var.subnet_group_name
  vpc_security_group_ids = [aws_security_group.joing_database_mysql.id]
  username               = var.db_master_username
  password               = var.db_master_password
  parameter_group_name   = aws_db_parameter_group.joing
  multi_az               = false
  skip_final_snapshot    = true
  publicly_accessible    = true
  enabled_cloudwatch_logs_exports = [
    "audit",
    "error",
    "general",
    "slowquery"
  ]

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "DB instance"
  }
}

resource "aws_db_parameter_group" "joing" {
  name         = "joing-pg"
  family       = "mysql8.0"
  skip_destroy = true

  parameter {
    name  = "log_connections"
    value = "1"
  }

  lifecycle {
    create_before_destroy = true
  }
}