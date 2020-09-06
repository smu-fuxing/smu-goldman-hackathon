resource "random_password" "cf_refer_secret" {
  length = 64
}

module "cf_web" {
  source = "github.com/riboseinc/terraform-aws-s3-cloudfront-website"

  fqdn                = var.domain_web
  ssl_certificate_arn = aws_acm_certificate_validation.web_cert.certificate_arn
  allowed_ips         = ["0.0.0.0/0"]

  refer_secret = random_password.cf_refer_secret.result

  index_document = "index.html"
  error_document = "404.html"

  force_destroy = "true"

  providers = {
    aws.main       = aws
    aws.cloudfront = aws.cloudfront
  }
}

resource "aws_iam_policy" "cf_web_policy" {
  name   = "CF_WEB_POLICY"
  policy = data.aws_iam_policy_document.cf_web_policy.json
}

data "aws_iam_policy_document" "cf_web_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:DeleteObject",
      "s3:GetBucketLocation"
    ]
    resources = [
      module.cf_web.s3_bucket_arn,
      "${module.cf_web.s3_bucket_arn}/*"
    ]
  }
}
