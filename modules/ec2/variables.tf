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

variable "user_data" {
  description = "Script opcional para inicializar la EC2"
  type        = string
  default     = ""
}

variable "create_bastion_host" {
  description = "Si es True crea el bastion hot en la subnet pública"
  type        = bool
  default     = false
}

variable "public_subnet_id" {
  description = "Public subnet for bastion host"
  type        = string
}

variable "bastion_sg_id" {
  description = "Security group ID for the bastion host"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name for connecting to EC2 instances"
  type        = string
  default     = null
}