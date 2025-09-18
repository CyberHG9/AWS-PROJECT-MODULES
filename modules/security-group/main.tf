# Create Security Group for access control
resource "aws_security_group" "this" {
  name        = var.sg_name
  description = "Security Group managed by Terraform"
  vpc_id      = var.vpc_id

  # Reglas de entrada (ejemplo: SSH y HTTP)
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ruta por default pa everybody
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Reglas de salida (permitimos todo por defecto) luego podemos ir agregando mas detalle
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}
