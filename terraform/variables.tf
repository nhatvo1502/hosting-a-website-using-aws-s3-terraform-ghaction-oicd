variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "bucket_name" {
  default = "static-web-031025-html-bucket"
  type    = string
}

variable "tfstate_bucket_name" {
  default = "static-web-031025-terraform-state-bucket"
  type = string
}