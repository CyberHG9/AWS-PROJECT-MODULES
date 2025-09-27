aws_region = "us-east-1"

tags = {
  Environment = "dev"
  Owner       = "Hesler"
}

# VPC
vpc_name           = "dev-vpc"
vpc_cidr           = "10.0.0.0/16"
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
ami_id        = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
instance_name = "dev-instance"
