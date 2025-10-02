aws_region = "us-east-1"

tags = {
  Environment = "dev"
  Owner       = "Hesler"
}

# VPC
vpc_name           = "dev-vpc"
vpc_cidr           = "10.0.0.0/16"
private_subnet_cidr = "10.0.2.0/24"
public_subnet_cidr = "10.0.1.0/24"
availability_zone  = "us-east-1a"

# Security Group
sg_name = "dev-sg"

# S3
bucket_name = "hesler-dev-bucket"
environment = "dev"
versioning  = true
acl         = "private"

# EC2
ami_id        = "ami-08982f1c5bf93d976"
instance_type = "t3.micro"
instance_name = "dev-instance"

# RDS Config (PostgreSQL)
db_identifier     = "postgres-db-dev"
db_engine         = "postgres"
db_engine_version = "15.3"         
db_instance_class = "db.t3.micro"  
db_name           = "mydb"
db_username       = "admin"