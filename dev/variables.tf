# NOTE: use "type" and avoid using default 
#HR Done

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR de la VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR de la Subnet Pública"
  type        = string
}

variable "az" {
  description = "Availability Zone"
  type        = string
}

variable "sg_name" {
  description = "Nombre del Security Group"
  type        = string
}

variable "instance_name" {
  description = "Nombre de la instancia EC2"
  type        = string
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}
