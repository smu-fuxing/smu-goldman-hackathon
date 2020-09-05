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
