# ===============================
# AWS Configuration
# ===============================
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "tags" {
  type        = map(string)
  default     = {}
}


# ===============================
# VPC CONFIG
# ===============================
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# Listas
variable "azs" {
  description = "Lista de zonas de disponibilidad"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Lista de CIDRs para las subnets públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de CIDRs para las subnets privadas"
  type        = list(string)
}


# ===============================
# SECURITY GROUP CONFIG
# ===============================
variable "sg_name" {
  description = "Name of the Security Group"
  type        = string
}

# ===============================
# S3 CONFIG
# ===============================
variable "bucket_name" {
  description = "Bucket name"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "versioning" {
  description = "Enable versioning in S3"
  type        = bool
}

variable "acl" {
  description = "ACL for S3 bucket"
  type        = string
}

# ===============================
# EC2 CONFIG
# ===============================
variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "instance_name" {
  description = "Name of EC2 instance"
  type        = string
}

# ===============================
# RDS CONFIG
# ===============================
variable "db_identifier" {
  description = "Identifier for RDS instance"
  type        = string
}

variable "db_engine" {
  description = "Database engine (postgres, mysql, etc.)"
  type        = string
}

variable "db_engine_version" {
  description = "Version of the database engine"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "db_username" {
  description = "Master username for the DB"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair to use for EC2 instances"
  type        = string
}

# Variables for Budgets

variable "name" {
  type = string
}

variable "budget_type" {
  type = string
}

variable "limit_amount" {
  type = number
}

variable "limit_unit" {
  type = string
}

variable "time_unit" {
  type = string
}

variable "comparison_operator" {
  type = string
}

variable "threshold" {
  type = number
}

variable "threshold_type" {
  type = string
}

variable "notification_type" {
  type = string
}

variable "sns_topic_name" {
  type = string
}

variable "email" {
  type = string
}
