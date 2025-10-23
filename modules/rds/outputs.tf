output "db_endpoint" {
  value = aws_db_instance.rds_instance.address
}

output "db_port" {
  value = aws_db_instance.rds_instance.port
}

#The outputs to get the Secrets Manager secret details
output "rds_secret_arn" {
  description = "ARN of the AWS Secrets Manager secret storing DB credentials"
  value       = aws_secretsmanager_secret.db_secret.arn
}

output "rds_secret_name" {
  description = "Name of the AWS Secrets Manager secret"
  value       = aws_secretsmanager_secret.db_secret.name
}