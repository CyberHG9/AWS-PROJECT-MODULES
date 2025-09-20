# use "type" and avoid using default
variable "region" {
  default = "us-east-1"
}

variable "vpc_name" {
  default = "Hesler-VPC"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "az" {
  default = "us-east-1a"
}

variable "sg_name" {
  description = "Nombre del Security Group"
  type        = string
  default     = "Default-SG"
}

variable "instance_name" {
  description = "Nombre de la instancia EC2"
  type        = string
  default     = "Default-EC2"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  default     = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
  default     = "default-project-bucket"
}
