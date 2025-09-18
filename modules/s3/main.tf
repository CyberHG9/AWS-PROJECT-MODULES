# Creamos el bucket S3
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.acl

  # Habilitamos versioning si se requiere
  versioning {
    enabled = var.versioning
  }

  tags = {
    Name = var.bucket_name
    Environment = var.environment
  }
}
