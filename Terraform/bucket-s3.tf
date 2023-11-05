/*
  bucket-s3.tf
  Archivo de configuración del bucket de S3.
*/

// Creación del bucket de S3 con el nombre de la variable "domain":
resource "aws_s3_bucket" "bucket-s3" {
  bucket = var.domain
  force_destroy = true
}

// Configuración para habilitar el almacenamiento de sitios web estáticos en el bucket de S3:
resource "aws_s3_bucket_website_configuration" "bucket-s3-static" {
  bucket = aws_s3_bucket.bucket-s3.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "404.html"
  }
}

// Configuraciones para habilitar el acceso público al bucket de S3:
resource "aws_s3_bucket_public_access_block" "bucket-s3-public" {
  bucket = aws_s3_bucket.bucket-s3.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket-s3-policy" {
  bucket = aws_s3_bucket.bucket-s3.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.bucket-s3.arn}/*"
        ]
      }
    ]
  })
}
