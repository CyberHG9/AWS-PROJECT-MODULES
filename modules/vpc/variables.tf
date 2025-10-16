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

# Lista de Availability Zones
variable "azs" {
  description = "Lista de Availability Zones a usar"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# CIDRs para public subnets, debe coincidir en longitud con azs
variable "public_subnet_cidrs" {
  description = "Lista de CIDRs para subnets públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# CIDRs para private subnets
variable "private_subnet_cidrs" {
  description = "Lista de CIDRs para subnets privadas"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}
