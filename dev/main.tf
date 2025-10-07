terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72.0"
    }
  }

  backend "s3" {
    bucket       = "terraform-states-hesler"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region
}

# Módulo VPC
module "vpc" {
  source              = "../modules/vpc"
  vpc_name            = var.vpc_name
  cidr_block          = var.vpc_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  az                  = var.availability_zone
}

# Módulo RDS
module "rds" {
  depends_on = [module.vpc, module.security_group]

  source            = "../modules/rds"
  db_identifier     = "mydb-dev"
  db_engine         = "postgres"        
  db_engine_version = "15.3"               
  db_instance_class = "db.t3.micro"        # dentro del free tier
  db_name           = "mydb"
  db_username       = "admin"
  sg_id             = module.security_group.sg_id
  private_subnet_id = module.vpc.private_subnet_id
}


# Módulo Security Group
module "security_group" {
  depends_on = [ module.vpc ]
  source  = "../modules/security-group"
  sg_name = var.sg_name
  vpc_id  = module.vpc.vpc_id
}

# Módulo S3
module "s3" {
  source      = "../modules/s3"
  bucket_name = var.bucket_name
  environment = var.environment
  versioning  = var.versioning
  acl         = var.acl
}

# Módulo EC2
# NOTE: CONFIGURE EC2 WITH KEY
module "ec2" {
  depends_on = [ module.vpc, module.security_group ]
  source        = "../modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_id
  sg_id         = module.security_group.sg_id
  instance_name = var.instance_name
  user_data = file("../modules/ec2/user_data_amazonlinux.sh")
}
