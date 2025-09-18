# Nombre de la VPC
variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}

# CIDR de la VPC
variable "cidr_block" {
  description = "CIDR block de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# CIDR de la subnet pública
variable "public_subnet_cidr" {
  description = "CIDR de la subnet pública"
  type        = string
  default     = "10.0.1.0/24"
}

# Availability Zone
variable "az" {
  description = "Zona de disponibilidad"
  type        = string
  default     = "us-east-1a"
}
