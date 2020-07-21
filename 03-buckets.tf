resource "aws_s3_bucket" "magicvideos_bucket" {
  bucket = var.aws_bucket_name
  acl = "private"

  cors_rule {
    allowed_origins = ["*"]
    allowed_headers = ["*"]
    allowed_methods = ["PUT","POST","GET","HEAD"]
    expose_headers = ["ETag"]
    max_age_seconds = 3000
  }

}
