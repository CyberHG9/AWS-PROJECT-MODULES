variable "ami_id" {
  description = "AMI de la instancia"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID donde se lanza la instancia"
  type        = string
}

variable "sg_id" {
  description = "Security Group ID para la instancia"
  type        = string
}

variable "instance_name" {
  description = "Nombre de la instancia"
  type        = string
}
