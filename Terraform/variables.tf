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
  default = "arn:aws:acm:eu-central-1:413330159251:certificate/5c5830d0-7fc8-4c4a-b182-e34f3fd15e72"
}
