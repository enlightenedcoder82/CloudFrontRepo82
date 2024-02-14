resource "aws_cloudfront_distribution" "romuluscloud" {
  origin {
    domain_name = aws_s3_bucket.romuluscloud_bucket.bucket_regional_domain_name
    origin_id   = "s3"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.OAI.cloudfront_access_identity_path
    }
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    # viewer_protocol_policy = "https-only"
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US","CA"]
    }
  }

  viewer_certificate {
  
    cloudfront_default_certificate = true
    ssl_support_method = "sni-only"
    acm_certificate_arn = data.aws_acm_certificate.issued.arn
    minimum_protocol_version = "TLSv1.2_2021"
  }

aliases = ["romuluscloud.com"] 


depends_on = [aws_cloudfront_origin_access_identity.OAI]
}

resource "aws_s3_bucket_policy" "OAI_policy" {
  bucket = aws_s3_bucket.romuluscloud_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json

  depends_on = [aws_cloudfront_distribution.romuluscloud]
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.romuluscloud_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.OAI.iam_arn]
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "OAI" {
}



