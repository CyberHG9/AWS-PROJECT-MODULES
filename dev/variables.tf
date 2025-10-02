variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "tags" {
  description = "Default tags applied to all resources"
  type        = map(string)
  default     = {}
}

# VPC
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type = string
}

#JUST FOR DDBB EXERCISE
variable "private_subnet_cidrs" {
  type = map(string)
  default = {
    "us-east-1a" = "10.0.2.0/24"
    "us-east-1b" = "10.0.3.0/24"
  }
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}
variable "availability_zone" {
  description = "Availability Zone to deploy the subnet"
  type        = string
}

# Security Group
variable "sg_name" {
  description = "Name of the Security Group"
  type        = string
}

# S3
variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}
variable "environment" {
  description = "Deployment environment (dev, prod, staging, etc.)"
  type        = string
}
variable "versioning" {
  description = "Enable versioning on the S3 bucket"
  type        = bool
  default     = true
}
variable "acl" {
  description = "Access Control List for the S3 bucket (private, public-read, etc.)"
  type        = string
  default     = "private"
}

# EC2
variable "ami_id" {
  description = "AMI ID to launch the EC2 instance"
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

# RDS
variable "db_identifier" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "db_engine_version" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}
