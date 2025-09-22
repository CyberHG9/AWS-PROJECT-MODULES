terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-states-hesler"   # bucket name
    key            = "dev/terraform.tfstate"    # tfstate de dev
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"          # tabla DynamoDB para locking
  }
}

provider "aws" {
  region  = var.region
  profile = "mywalkup"

## is missing the config of default tags, but first create the table in DynamoDB.
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
  vpc_id  = module.vpc.vpc_id # NOTE: if modules depend in another, use "depends" attribute, see tf doc for this.
                              #HR module security_group depends of module vpc, bc needs vpc_id, Terraform detects this automatically, bc vpc_id = module.vpc.vpc_id and that create a implicit dependency.
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


# NOTE: move this to outputs.tf
#HR resolved, moved to outputs.tf 