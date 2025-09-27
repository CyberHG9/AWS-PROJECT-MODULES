# Nombre del bucket
output "bucket_name" {
  value       = aws_s3_bucket.bucket.bucket
  description = "Nombre del bucket S3 creado"
}

# ARN del bucket
output "bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "ARN del bucket S3 creado"
}
