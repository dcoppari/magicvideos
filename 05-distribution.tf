resource "aws_cloudfront_origin_access_identity" "magicvideos_origin_access" {
  comment = "magicvideos_videos"
}

resource "aws_cloudfront_distribution" "magicvideos_distribution" {
  comment = "magicvideos_videos"

  origin {
    domain_name = aws_s3_bucket.magicvideos_bucket.bucket_regional_domain_name
    origin_id   = aws_cloudfront_origin_access_identity.magicvideos_origin_access.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.magicvideos_origin_access.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = false
  default_root_object = ""

  default_cache_behavior {

    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    target_origin_id = aws_cloudfront_origin_access_identity.magicvideos_origin_access.id

    forwarded_values {
      query_string = true

      cookies {
        forward = "whitelist"
        whitelisted_names = [ "Origin" ]
      }

      headers = ["Origin"]
    }

    viewer_protocol_policy = "https-only"
    min_ttl                = 3600
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
     restriction_type = "blacklist"
     locations        = []
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

data "aws_iam_policy_document" "s3_distribution_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = [ "${aws_s3_bucket.magicvideos_bucket.arn}/*" ]

    principals {
      type        = "AWS"
      identifiers = [ aws_cloudfront_origin_access_identity.magicvideos_origin_access.iam_arn ]
    }
  }
}

resource "aws_s3_bucket_policy" "magicvideos_bucket_policy" {
  bucket = aws_s3_bucket.magicvideos_bucket.id
  policy = data.aws_iam_policy_document.s3_distribution_policy.json
}
