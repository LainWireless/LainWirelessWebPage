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
  default = "arn:aws:acm:us-east-1:413330159251:certificate/9f9c1db3-e440-4ed0-b3a0-5081b3c68824"
}
