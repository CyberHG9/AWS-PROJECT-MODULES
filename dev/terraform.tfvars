aws_region = "us-east-1"

tags = {
  Environment = "dev"
  Owner       = "Hesler"
}

# VPC
vpc_name = "dev-vpc"
vpc_cidr = "10.0.0.0/16"

# >>> ADDED: listas de AZs y CIDRs
azs = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs = ["10.0.100.0/24", "10.0.200.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]

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
key_name      = "Hesler-Key"

# RDS Config (PostgreSQL)
db_identifier     = "postgres-db-dev"
db_engine         = "postgres"
db_engine_version = "15"
db_instance_class = "db.t3.micro"
db_name           = "mydb"
db_username       = "hesleruser"

# Budget Alarm

name                = "dev-environment-budget"
budget_type         = "COST"
limit_amount        = 40
limit_unit          = "USD"
time_unit           = "MONTHLY"
comparison_operator = "GREATER_THAN"
threshold           = 80
threshold_type      = "PERCENTAGE"
notification_type   = "ACTUAL"
sns_topic_name      = "dev-budget-alerts"
email               = "tu-email@ejemplo.com"
