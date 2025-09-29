# NOTE: outputs at module level are meant for data that needs to be used in another modules (like for example sg uses vpc.id) UNDERSTOOD
# Output de la VPC ID
output "vpc_id" {
  value = aws_vpc.vpc.id
}

# Output de la Subnet pública
output "public_subnet_id" {
  value = aws_subnet.public.id
}

# ID del Internet Gateway
output "internet_gateway_id" {
  description = "ID del Internet Gateway asociado"
  value       = aws_internet_gateway.gw.id
}

# ID de la Route Table pública
output "public_route_table_id" {
  description = "ID de la route table pública"
  value       = aws_route_table.public.id
}
