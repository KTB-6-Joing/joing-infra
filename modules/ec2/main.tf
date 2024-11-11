resource "aws_instance" "redis" {
  ami                    = var.settings.ami
  instance_type          = var.settings.type
  subnet_id              = var.public_subnet
  key_name               = var.settings.key_name
  vpc_security_group_ids = [aws_security_group.joing_redis.id]

  root_block_device {
    volume_size           = var.settings.volume_size
    delete_on_termination = true # 인스턴스 종료 시 볼륨 삭제
  }

  tags = {
    Name = "redis-instance"
  }
}