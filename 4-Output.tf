output "cloudfront_url" {
  value = aws_cloudfront_distribution.romuluscloud.domain_name
  description = "CloudFront domain name"
}

output "cloudfront_url_link" {
  value = format("https://%s", aws_cloudfront_distribution.romuluscloud.domain_name)
  description = "Clickable CloudFront URL"
}
