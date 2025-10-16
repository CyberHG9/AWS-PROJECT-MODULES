variable "sg_name" {
  description = "Nombre del security group"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se creará el SG"
  type        = string
}

variable "backend_ingress_rules" {
  description = "Ingress rules for the backend security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = [
    {
      description = "Allow SSH (restrict this in production!)"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTPS just to Mario Rosales"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["143.208.18.118/32"]
    }
  ]
}
