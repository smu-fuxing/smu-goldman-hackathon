resource "aws_ecs_cluster" "main" {
  name = "Mavis_GS_Cluster"
}

resource "aws_iam_policy" "cluster" {
  name = "Mavis_GS_Cluster_Policy"
  policy = data.aws_iam_policy_document.cluster.json
}

data "aws_iam_policy_document" "cluster" {
  statement {
    sid = "RegisterTaskDefinition"
    effect = "Allow"
    actions = [
      "ecs:RegisterTaskDefinition"
    ]
    resources = [
      "*"]
  }

  statement {
    sid = "PassRolesInTaskDefinition"
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = [
      aws_iam_role.execution.arn,
      aws_iam_role.task.arn
    ]
  }

  statement {
    sid = "DeployService"
    effect = "Allow"
    actions = [
      "ecs:UpdateService",
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinition"
    ]
    resources = [
      "*"]
  }
}
