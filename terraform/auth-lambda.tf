data "template_file" "cognito_pre_sign_up" {
  template = file("lambda/cognito_pre_signup.js")
}

data "archive_file" "cognito_pre_sign_up" {
  type        = "zip"
  output_path = "${path.module}/.zip/cognito-pre-signup.zip"

  source {
    filename = "index.js"
    content  = data.template_file.cognito_pre_sign_up.rendered
  }
}

data "aws_iam_policy_document" "cognito_pre_sign_up" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "cognito_pre_sign_up" {
  name               = "COGNITO_PRE_SIGN_UP"
  assume_role_policy = data.aws_iam_policy_document.cognito_pre_sign_up.json
}

resource "aws_iam_role_policy_attachment" "cognito_pre_sign_up" {
  role       = aws_iam_role.cognito_pre_sign_up.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_lambda_function" "cognito_pre_sign_up" {
  function_name    = "cognito-pre-signup"
  filename         = data.archive_file.cognito_pre_sign_up.output_path
  source_code_hash = data.archive_file.cognito_pre_sign_up.output_base64sha256
  role             = aws_iam_role.cognito_pre_sign_up.arn
  runtime          = "nodejs12.x"
  handler          = "index.handler"
  memory_size      = 128
  timeout          = 3
  publish          = true
}
