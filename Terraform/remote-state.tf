/*
  remote-state.tf
  Archivo de configuración del estado remoto.
*/

terraform {
  backend "s3" {
    bucket = "lainwireless-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
