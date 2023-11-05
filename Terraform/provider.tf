/*
  providers.tf
  Archivo con la configuración de los providers de Terraform. Un provider es un plugin que nos permite interactuar con un proveedor de infraestructura (en nuestro caso, AWS).
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
