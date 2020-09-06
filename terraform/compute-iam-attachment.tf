resource "aws_iam_role_policy_attachment" "dynamodb" {
  role       = aws_iam_role.task_role.id
  policy_arn = aws_iam_policy.dynamodb.arn
}

resource "aws_iam_policy" "dynamodb" {
  name   = "Mavis_GS_DynamoDB"
  policy = data.aws_iam_policy_document.dynamodb.json
}
