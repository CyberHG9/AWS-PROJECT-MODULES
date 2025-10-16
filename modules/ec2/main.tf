# Crear instancia EC2 en subnet pública
resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]


  associate_public_ip_address = false # disable public IP assignment for private subnet.

  #Script de inicialización
  user_data = file("${path.module}/user_data_amazonlinux.sh")


  tags = {
    Name = var.instance_name
  }
}

# resource "aws_instance" "bastion_host" {
#   count = var.bastion_host ? 1 : 0
#   ami = "algo"
#   subnet_id = "algo"
#   instance_type = "algo"
#   associate_public_ip_address = "algo"
# }

resource "aws_instance" "bastion_host" {
  count = var.create_bastion_host ? 1 : 0  # Se crea solo si lo activas en el tfvars o main

  ami                    = var.ami_id
  instance_type          = "t3.micro"
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.bastion_sg_id]
  associate_public_ip_address = true  # IP pública para acceso SSH
  key_name               = var.key_name  # SSH key configurada en AWS

  # Puedes agregar user_data básico si quieres instalar algo como htop o actualizar paquetes
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y postgresql telnet
              EOF

  tags = {
    Name = "${var.instance_name}-bastion"
  }
}