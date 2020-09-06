resource "aws_iam_role" "task" {
  name = "ECS_TASK"

  assume_role_policy = data.aws_iam_policy_document.ecs_tasks.json
}

resource "aws_iam_role" "execution" {
  name = "ECS_EXECUTION"

  assume_role_policy = data.aws_iam_policy_document.ecs_tasks.json
}

data "aws_iam_policy_document" "ecs_tasks" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "execution" {
  name = "ECS_EXECUTION"
  role = aws_iam_role.execution.id

  policy = data.aws_iam_policy_document.execution.json
}

data "aws_iam_policy_document" "execution" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeTags",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:UpdateContainerInstancesState",
      "ecs:Submit*",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "secretsmanager:GetSecretValue"
    ]
    resources = [
      aws_secretsmanager_secret.github_token.arn,
      aws_secretsmanager_secret.news_api_token.arn,
      aws_secretsmanager_secret.fa_api_key.arn,
      aws_kms_key.default.arn
    ]
  }
}

resource "aws_iam_instance_profile" "ecs" {
  name = "ECS_INSTANCE_PROFILE"
  role = aws_iam_role.ecs.name
}

resource "aws_iam_role" "ecs" {
  name = "ECS_ROLE"
  path = "/"

  assume_role_policy = data.aws_iam_policy_document.ecs.json
}

data "aws_iam_policy_document" "ecs" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
