variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}

variable "acl" {
  description = "ACL del bucket (private, public-read, etc.)"
  type        = string
  default     = "private"
}

variable "versioning" {
  description = "Habilitar versioning en el bucket"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Entorno (dev, prod, etc.) para etiquetar el bucket"
  type        = string
  default     = "dev"
}
