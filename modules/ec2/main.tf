resource "aws_instance" "redis" {
  ami                    = var.settings_redis.ami
  instance_type          = var.settings_redis.type
  subnet_id              = var.public_subnet
  key_name               = var.settings_redis.key_name
  vpc_security_group_ids = [aws_security_group.joing_redis.id]

  root_block_device {
    volume_size           = var.settings_redis.volume_size
    delete_on_termination = true # 인스턴스 종료 시 볼륨 삭제
  }

  tags = {
    Name = "redis-instance"
  }
}

resource "aws_instance" "rabbitmq" {
  ami                    = var.settings_rabbitmq.ami
  instance_type          = var.settings_rabbitmq.type
  subnet_id              = var.public_subnet
  key_name               = var.settings_rabbitmq.key_name
  vpc_security_group_ids = [aws_security_group.joing_rabbitmq.id]

  root_block_device {
    volume_size           = var.settings_rabbitmq.volume_size
    delete_on_termination = true # 인스턴스 종료 시 볼륨 삭제
  }

  tags = {
    Name = "rabbitmq-instance"
  }
}