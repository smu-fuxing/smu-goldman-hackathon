resource "aws_route53_zone" "main" {
  name          = var.domain
  force_destroy = true
}

resource "aws_route53_record" "web" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_web
  type    = "A"

  alias {
    name                   = module.cf_web.cf_domain_name
    zone_id                = module.cf_web.cf_hosted_zone_id
    evaluate_target_health = false
  }
}

###
### ACM:
### provider = aws
###

resource "aws_acm_certificate" "api_cert" {
  domain_name       = var.domain_api
  validation_method = "DNS"
}

resource "aws_route53_record" "api_cert_validation" {
  name    = aws_acm_certificate.api_cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.api_cert.domain_validation_options[0].resource_record_type
  zone_id = aws_route53_zone.main.id
  records = [aws_acm_certificate.api_cert.domain_validation_options[0].resource_record_value]
  ttl     = 60

  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "api_cert" {
  certificate_arn         = aws_acm_certificate.api_cert.arn
  validation_record_fqdns = [aws_route53_record.api_cert_validation.fqdn]
}


###
### ACM:
### provider = aws.cloudfront
###

resource "aws_acm_certificate" "web_cert" {
  provider          = aws.cloudfront
  domain_name       = var.domain_web
  validation_method = "DNS"
}

resource "aws_route53_record" "web_cert_validation" {
  name    = aws_acm_certificate.web_cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.web_cert.domain_validation_options[0].resource_record_type
  zone_id = aws_route53_zone.main.id
  records = [aws_acm_certificate.web_cert.domain_validation_options[0].resource_record_value]
  ttl     = 60

  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "web_cert" {
  provider                = aws.cloudfront
  certificate_arn         = aws_acm_certificate.web_cert.arn
  validation_record_fqdns = [aws_route53_record.web_cert_validation.fqdn]
}
