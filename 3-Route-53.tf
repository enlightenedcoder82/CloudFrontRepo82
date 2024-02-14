#Create a record in route 53
resource "aws_route53_record" "romuluscloud" {
  zone_id = data.aws_route53_zone.selected.id
  name = "romuluscloud.com"
  type = "A"

  alias {
    name   = aws_cloudfront_distribution.romuluscloud.domain_name
    zone_id = aws_cloudfront_distribution.romuluscloud.hosted_zone_id
    evaluate_target_health = true
  }

  # Ensure the record is deleted when Terraform is applied
  lifecycle {
    create_before_destroy = true
  }
}

#Get the acm certificate issued to our domain name
data "aws_acm_certificate" "issued" {
  domain = "romuluscloud.com"
  statuses = ["ISSUED"]
  most_recent = true
}

#Get the route53 id
data "aws_route53_zone" "selected" {
  name         = "romuluscloud.com"
}
#Get the s3 origin id
locals {
  s3_origin_id = "s3"
}


