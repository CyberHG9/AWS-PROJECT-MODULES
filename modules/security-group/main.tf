# Create Security Group for backend EC2
resource "aws_security_group" "backend_sg" {
  name        = var.sg_name
  description = "Security Group for backend EC2 instance"
  vpc_id      = var.vpc_id

  # Ingress rules
  ingress {
    description = "Allow SSH (restrict this in production!)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #CHANGE THIS TO RESTRICT ACCESS IF NEEDED
  }

  # Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #CHANGE THIS TO RESTRICT ACCESS IF NEEDED
  }

  tags = {
    Name = var.sg_name
  }
}
