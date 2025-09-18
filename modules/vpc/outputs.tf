# Output de la VPC ID
output "vpc_id" {
  value = aws_vpc.this.id
}

# Output de la Subnet pública
output "public_subnet_id" {
  value = aws_subnet.public.id
}
