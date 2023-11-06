/*
  variables.tf
  Archivo con las variables que usaremos en los archivos de configuración de los recursos.

  Variables en uso en los ficheros:
    - providers.tf
    - bucket-s3.tf
    - cloudfront.tf
*/

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "domain" {
  type = string
  default = "www.lainwireless.es"
}

variable "aws_arn_certificado" {
  type = string
  default = "arn:aws:acm:us-east-1:413330159251:certificate/4955b3b0-5a93-4934-9df6-6564f885c086"
}
