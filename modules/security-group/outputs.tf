output "sg_id" {
  value = aws_security_group.backend_sg.id
}

# Output del SG para RDS
output "rds_sg_id" {
  description = "ID del Security Group para RDS"
  value       = aws_security_group.rds_sg.id
}

# Output del SG para backend o EC2 interno
output "backend_sg_id" {
  description = "ID del Security Group del backend/EC2"
  value       = aws_security_group.backend_sg.id
}

# Output del SG del bastion host (si existe)
output "bastion_sg_id" {
  description = "ID del Security Group del bastion host"
  value       = aws_security_group.bastion_sg.id
}
