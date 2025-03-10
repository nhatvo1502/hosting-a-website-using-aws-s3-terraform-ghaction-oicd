provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "web" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "web" {
  bucket = aws_s3_bucket.web.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "web" {
  bucket                  = aws_s3_bucket.web.id
  block_public_acls       = true
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "web" {
  bucket = aws_s3_bucket.web.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.web.id
  key          = "index.html"
  source       = "./website/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.web.id
  key          = "error.html"
  source       = "./website/error.html"
  content_type = "text/html"
  
}

resource "aws_s3_bucket_policy" "web" {
  depends_on = [aws_s3_bucket_public_access_block.web]
  bucket     = aws_s3_bucket.web.id
  policy     = data.aws_iam_policy_document.web.json
}

data "aws_iam_policy_document" "web" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.web.arn}/*"
    ]
  }
}