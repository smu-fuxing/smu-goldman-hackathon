resource "aws_kms_key" "default" {
  description             = "Default Key"
  deletion_window_in_days = 7
}

resource "aws_secretsmanager_secret" "github_token" {
  name       = "GITHUB_TOKEN_PROJECT_READ_ONLY_KMS"
  kms_key_id = aws_kms_key.default.key_id
}

resource "aws_secretsmanager_secret_version" "github_token" {
  secret_id     = aws_secretsmanager_secret.github_token.id
  secret_string = "FILL IN CONSOLE"

  lifecycle {
    ignore_changes = [secret_string]
  }
}

resource "aws_secretsmanager_secret" "news_api_token" {
  name       = "NEWS_API_TOKEN"
  kms_key_id = aws_kms_key.default.key_id
}

resource "aws_secretsmanager_secret_version" "news_api_token" {
  secret_id     = aws_secretsmanager_secret.news_api_token.id
  secret_string = "FILL IN CONSOLE"

  lifecycle {
    ignore_changes = [secret_string]
  }
}

resource "aws_secretsmanager_secret" "fa_api_key" {
  name       = "FA_API_KEY"
  kms_key_id = aws_kms_key.default.key_id
}

resource "aws_secretsmanager_secret_version" "fa_api_key" {
  secret_id     = aws_secretsmanager_secret.fa_api_key.id
  secret_string = "FILL IN CONSOLE"

  lifecycle {
    ignore_changes = [secret_string]
  }
}
