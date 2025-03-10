resource "aws_s3_bucket" "tfstate" {
  bucket = var.tfstate_bucket_name

  tags = {
    Name        = var.tfstate_bucket_name
    Environment = "dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}