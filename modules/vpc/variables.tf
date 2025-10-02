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

# CIDR de la subnet privada
variable "private_subnet_cidr" {
  description = "CIDR de la subnet privada"
  type        = string
  default     = "10.0.2.0/24"
}

# variable "private_subnet_cidrs" {
#   type = map(string)
#   default = {
#     "us-east-1a" = "10.0.2.0/24"
#     "us-east-1b" = "10.0.3.0/24"
#   }
# }



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
