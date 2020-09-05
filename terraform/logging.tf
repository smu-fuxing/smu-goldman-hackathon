locals {
  awslogs = {
    group  = aws_cloudwatch_log_group.mavis.name
    region = data.aws_region.current.name
  }
}

resource "aws_cloudwatch_log_group" "mavis" {
  name              = "/ecs/mavis"
  retention_in_days = 1
}
