resource "aws_cloudfront_distribution" "giveacube-website" {
  aliases = ["giveacube.org", "giveacube.com", "www.giveacube.com", "www.giveacube.org"]

  default_cache_behavior {
    allowed_methods        = ["HEAD", "GET"]
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    cached_methods         = ["HEAD", "GET"]
    compress               = "false"
    default_ttl            = "0"
    max_ttl                = "0"
    min_ttl                = "0"
    smooth_streaming       = "false"
    target_origin_id       = "S3-giveacube-website"
    viewer_protocol_policy = "redirect-to-https"
  }

  default_root_object = "index.html"
  enabled             = "true"
  http_version        = "http2"
  is_ipv6_enabled     = "true"

  origin {
    domain_name = aws_s3_bucket.giveacube-website.bucket_domain_name
    origin_id   = "S3-giveacube-website"
    origin_path = "/static"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.giveacube-website.cloudfront_access_identity_path
    }
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  retain_on_delete = "false"

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.giveacube-website.arn
    cloudfront_default_certificate = "false"
    minimum_protocol_version       = "TLSv1.2_2019"
    ssl_support_method             = "sni-only"
  }
}
