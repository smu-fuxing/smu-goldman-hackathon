output "domain_nameservers" {
  value = aws_route53_zone.main.name_servers
}

output "github_actions_AWS_ACCESS_KEY_ID" {
  value = aws_iam_access_key.github_actions.id
}

output "github_actions_AWS_SECRET_ACCESS_KEY" {
  value = aws_iam_access_key.github_actions.secret
}

output "github_actions_AWS_REGION" {
  value = data.aws_region.current.name
}

output "github_actions_AWS_S3_WEB_APP_BUCKET" {
  value = module.cf_web.s3_bucket_id
}

output "cognito_setup" {
  value = {
    region              = data.aws_region.current.name
    userPoolId          = aws_cognito_user_pool_client.web.user_pool_id
    userPoolWebClientId = aws_cognito_user_pool_client.web.id
  }
}
