# Output de la VPC ID
output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.vpc.id
}

# Usamos siempre el FOR para recorrer las subnets, ya que son varios.  

# Subnets públicas (lista de IDs)
output "public_subnet_ids" {
  description = "Lista de subnets públicas creadas"
  value       = [for s in aws_subnet.public : s.id]
}

# Subnets privadas (lista de IDs)
output "private_subnet_ids" {
  description = "Lista de subnets privadas creadas"
  value       = [for s in aws_subnet.private : s.id]
}

# Internet Gateway
output "internet_gateway_id" {
  description = "ID del Internet Gateway asociado"
  value       = aws_internet_gateway.gw.id
}

#  Route Table pública
output "public_route_table_id" {
  description = "ID de la Route Table pública"
  value       = aws_route_table.public.id
}

# Route Table privada 
output "private_route_table_id" {
  description = "ID de la Route Table privada"
  value       = aws_route_table.private.id
}

