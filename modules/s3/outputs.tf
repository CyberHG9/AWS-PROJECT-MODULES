# Output del nombre del bucket
output "bucket_name" {
  value = aws_s3_bucket.this.id
}

# Output del ARN del bucket
output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}
