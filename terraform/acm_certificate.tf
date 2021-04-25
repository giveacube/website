resource "aws_acm_certificate" "giveacube-website" {
  domain_name = "giveacube.com"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  subject_alternative_names = [
    "www.giveacube.com",
    "giveacube.org",
    "www.giveacube.org",
  ]

  validation_method = "DNS"
}
