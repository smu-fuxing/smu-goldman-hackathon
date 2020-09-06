resource "aws_iam_user" "github_actions" {
  name = "github_actions"
}

resource "aws_iam_access_key" "github_actions" {
  user = aws_iam_user.github_actions.name
}

resource "aws_iam_user_policy_attachment" "cf_web_policy" {
  policy_arn = aws_iam_policy.cf_web_policy.arn
  user       = aws_iam_user.github_actions.name
}

resource "aws_iam_user_policy_attachment" "cluster" {
  policy_arn = aws_iam_policy.cluster.arn
  user       = aws_iam_user.github_actions.name
}
