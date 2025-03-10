terraform {
  backend "s3" {
    bucket = "static-web-031025-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
