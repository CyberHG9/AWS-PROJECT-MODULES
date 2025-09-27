# ID de la instancia
output "instance_id" {
  value       = aws_instance.ec2.id
  description = "ID de la instancia EC2 creada"
}

# Dirección pública
output "public_ip" {
  value       = aws_instance.ec2.public_ip
  description = "IP pública de la instancia EC2"
}

# Dirección privada
output "private_ip" {
  value       = aws_instance.ec2.private_ip
  description = "IP privada de la instancia EC2"
}
