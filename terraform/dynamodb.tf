module "dynamodb_table_user" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name         = "mavis-gs.User"
  billing_mode = "PROVISIONED"

  hash_key = "userId"

  attributes = [
    {
      name = "userId"
      type = "S"
    }
  ]

  read_capacity  = 10
  write_capacity = 5

  autoscaling_read = {
    target_value = 60
    max_capacity = 50
  }

  autoscaling_write = {
    target_value = 60
    max_capacity = 25
  }
}

module "dynamodb_table_user_item" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name         = "mavis-gs.UserItem"
  billing_mode = "PROVISIONED"

  hash_key  = "userId"
  range_key = "itemId"

  attributes = [
    {
      name = "userId"
      type = "S"
    },
    {
      name = "itemId"
      type = "S"
    }
  ]

  read_capacity  = 10
  write_capacity = 5

  autoscaling_read = {
    target_value = 60
    max_capacity = 50
  }

  autoscaling_write = {
    target_value = 60
    max_capacity = 25
  }
}

data "aws_iam_policy_document" "dynamodb" {
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem"
    ]

    resources = [
      module.dynamodb_table_user.this_dynamodb_table_arn,
      module.dynamodb_table_user_item.this_dynamodb_table_arn,
    ]
  }
}
