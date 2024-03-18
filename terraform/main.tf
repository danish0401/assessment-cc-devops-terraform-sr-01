resource "aws_s3_bucket" "fsl_bucket" {
  bucket = var.bucket_name

  tags = var.common_tags
}


# I am using official documentation
resource "aws_s3_bucket_website_configuration" "fsl_bucket_config" {
  bucket = aws_s3_bucket.fsl_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

# for basic example we dont' need them
}

resource "aws_s3_bucket_public_access_block" "fsl_access_block" {
  bucket = aws_s3_bucket.fsl_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "fsl_bucket_policy" {
  bucket = aws_s3_bucket.fsl_bucket.id

  policy = jsonencode({
    Version = "2012-12-17"
    Statement = [
        {
            Effect = "Allow"
            Principal = "*"
            Action = [
                "s3.GetObject"
            ]
            Resource = [
                "${aws_s3_bucket.fsl_bucket.arn}/*"
            ]
        }
    ]
  })
}
