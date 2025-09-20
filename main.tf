provider "aws" {
  region = var.region
}

# Llamamos al módulo de VPC
module "vpc" {
  source             = "./modules/vpc"
  vpc_name           = var.vpc_name
  cidr_block         = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  az                 = var.az
}


# Llamamos al módulo Security Group
module "security_group" {
  source  = "./modules/security-group"
  sg_name = var.sg_name
  vpc_id  = module.vpc.vpc_id
}

# Llamamos al módulo EC2
module "ec2" {
  source        = "./modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_id
  sg_id         = module.security_group.sg_id
  instance_name = var.instance_name
}

# Llamamos al modulo de S3

module "s3" {
  
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
  acl         = "private"
  versioning  = true
  environment = "dev"
}

# Output de la VPC
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

#OUTPUT EC2

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

#OUTPUT S3

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}