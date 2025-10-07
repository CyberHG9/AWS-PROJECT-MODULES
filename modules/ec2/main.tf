# Crear instancia EC2 en subnet pública
resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true

  #Script de inicialización
  user_data = file("${path.module}/user_data_amazonlinux.sh")


  tags = {
    Name = var.instance_name
  }
}

