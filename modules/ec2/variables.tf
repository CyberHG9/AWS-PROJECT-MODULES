# AMI de la instancia
variable "ami_id" {
  description = "ID de la AMI para lanzar la instancia"
  type        = string
}

# Tipo de instancia
variable "instance_type" {
  description = "Tipo de la instancia EC2"
  type        = string
  default     = "t2.micro"
}

# Subnet ID
variable "subnet_id" {
  description = "ID de la Subnet donde se desplegará la instancia"
  type        = string
}

# Security Group ID
variable "sg_id" {
  description = "ID del Security Group asociado a la instancia"
  type        = string
}

# Nombre de la instancia
variable "instance_name" {
  description = "Nombre de la instancia EC2"
  type        = string
}
