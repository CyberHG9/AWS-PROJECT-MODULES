output "db_endpoint" {
  value = aws_db_instance.rds_instance.address
}

output "db_port" {
  value = aws_db_instance.rds_instance.port
}
