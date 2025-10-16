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

# Módulo VPC - agregamos listas ahora
module "vpc" {
  source               = "../modules/vpc"
  vpc_name             = var.vpc_name
  cidr_block           = var.vpc_cidr
  azs                  = var.azs                     # lista de AZs
  public_subnet_cidrs  = var.public_subnet_cidrs     # lista CIDRs public
  private_subnet_cidrs = var.private_subnet_cidrs    # lista CIDRs private
}

# Módulo RDS (usar lista de private_subnet_ids)
module "rds" {
  depends_on = [module.vpc, module.security_group]

  source                = "../modules/rds"
  db_identifier         = var.db_identifier
  db_engine             = var.db_engine
  db_engine_version     = var.db_engine_version
  db_instance_class     = var.db_instance_class
  db_name               = var.db_name
  db_username           = var.db_username
  sg_id                 = module.security_group.rds_sg_id   # usar rds SG
  private_subnet_ids    = module.vpc.private_subnet_ids     # Pass the list of private subnet IDs
}

# Módulo Security Group 
module "security_group" {
  depends_on = [module.vpc]
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
# NOTE: move ec2 api app to private subnet
# NOTE: make that you could dinamically add a bastion host
module "ec2" {
  source        = "../modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.private_subnet_ids[0]
  sg_id         = module.security_group.backend_sg_id
  instance_name = var.instance_name
  user_data     = file("../modules/ec2/user_data_amazonlinux.sh")

  # >>> Bastion variables
  create_bastion_host = true
  public_subnet_id    = module.vpc.public_subnet_ids[0]
  bastion_sg_id       = module.security_group.bastion_sg_id
  key_name            = var.key_name
}

# data "aws_ssm_parameter" "foo" {
#   name = "test"
# }
# output "test" {
#   value = data.aws_ssm_parameter.foo.insecure_value
# }
