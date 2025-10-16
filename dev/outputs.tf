# VPC outputs
output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}
output "public_subnet_id" {
  description = "ID of the created public subnet"
  value       = module.vpc.public_subnet_ids[0]
}

# Security Group outputs
output "sg_id" {
  description = "ID of the created Security Group"
  value       = module.security_group.sg_id
}

# S3 outputs
output "s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = module.s3.bucket_name
}
output "s3_bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = module.s3.bucket_arn
}

# EC2 outputs
output "ec2_instance_id" {
  description = "ID of the created EC2 instance"
  value       = module.ec2.instance_id
}
output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2.public_ip
}
output "ec2_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.ec2.private_ip
}

output "rds_endpoint" {
  description = "value of the RDS endpoint"
  value = module.rds.db_endpoint
}

output "rds_port" {
  description = "value of the RDS port"
  value = module.rds.db_port
}
