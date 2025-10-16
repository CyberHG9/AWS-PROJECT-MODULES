# Create Security Group for backend EC2
resource "aws_security_group" "backend_sg" {
  name        = var.sg_name
  description = "Security Group for backend EC2 instance"
  vpc_id      = var.vpc_id
 # Dynamic block para las reglas de ingreso
  dynamic "ingress" {
    for_each = var.backend_ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # # Ingress rules
  # ingress {
  #   description = "Allow SSH (restrict this in production!)"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # ingress {
  #   description = "Allow HTTP"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"] #CHANGE THIS TO RESTRICT ACCESS IF NEEDED
  # }

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

#Bastion Host Security Group
resource "aws_security_group" "bastion_sg" {
  name        = "${var.sg_name}-bastion"
  description = "Security Group for Bastion Host (Public)"
  vpc_id      = var.vpc_id
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.sg_name}-rds"
  description = "Security Group for RDS"
  vpc_id      = var.vpc_id

  # Definir relas luego
  ingress {
    description = "Allow Postgres"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.sg_name}-rds"
  }
}
