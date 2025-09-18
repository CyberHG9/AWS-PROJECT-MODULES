variable "sg_name" {
  description = "Nombre del security group"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se creará el SG"
  type        = string
}
