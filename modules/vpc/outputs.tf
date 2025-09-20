# NOTE: outputs at module level are meant for data that needs to be used in another modules (like for example sg uses vpc.id)
# Output de la VPC ID
output "vpc_id" {
  value = aws_vpc.this.id
}

# Output de la Subnet pública
output "public_subnet_id" {
  value = aws_subnet.public.id
}
