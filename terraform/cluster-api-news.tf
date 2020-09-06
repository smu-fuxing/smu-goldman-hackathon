resource "aws_lb_listener_rule" "api_news" {
  listener_arn = module.lb.https_listener_arns[0]

  action {
    type             = "forward"
    target_group_arn = module.lb.target_group_arns[2]
  }

  condition {
    path_pattern {
      values = ["/news/*"]
    }
  }
}

resource "aws_ecs_service" "api_news" {
  name    = "api-news"
  cluster = aws_ecs_cluster.main.id

  task_definition = aws_ecs_task_definition.api_news.arn

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  desired_count                      = 0

  load_balancer {
    target_group_arn = module.lb.target_group_arns[2]
    container_name   = "service"
    container_port   = 3000
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  launch_type         = "EC2"
  scheduling_strategy = "REPLICA"

  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_ecs_task_definition" "api_news" {
  family = "api-news"

  network_mode       = "bridge"
  task_role_arn      = aws_iam_role.task.arn
  execution_role_arn = aws_iam_role.execution.arn

  container_definitions = <<-EOF
[
  ${module.ecs_container_definition_api_news.json_map_encoded}
]
EOF

  requires_compatibilities = ["EC2"]
}

module "ecs_container_definition_api_news" {
  source  = "cloudposse/ecs-container-definition/aws"
  version = "0.41.0"

  container_name               = "service"
  container_image              = "docker.pkg.github.com/fuxingloh/smu-goldman-hackathon/api-news:latest"
  container_memory_reservation = 256

  essential = true

  port_mappings = [
    {
      hostPort      = 0
      containerPort = 3000
      protocol      = "tcp"
    }
  ]

  environment = [
  ]

  secrets = [
    {
      name      = "NEWS_API_TOKEN"
      valueFrom = aws_secretsmanager_secret.news_api_token.arn
    }
  ]

  log_configuration = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = local.awslogs.group
      awslogs-region        = local.awslogs.region
      awslogs-stream-prefix = "api-news"
    }
  }

  repository_credentials = {
    credentialsParameter = aws_secretsmanager_secret.github_token.arn
  }
}

resource "aws_appautoscaling_target" "api_news" {
  min_capacity = 1
  max_capacity = 5

  resource_id = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.api_news.name}"

  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

//resource "aws_appautoscaling_policy" "api_news" {
//  name        = "ecs_cluster_api_news"
//  policy_type = "TargetTrackingScaling"
//
//  resource_id        = aws_appautoscaling_target.api_news.resource_id
//  scalable_dimension = aws_appautoscaling_target.api_news.scalable_dimension
//  service_namespace  = aws_appautoscaling_target.api_news.service_namespace
//
//  target_tracking_scaling_policy_configuration {
//    predefined_metric_specification {
//      predefined_metric_type = "ALBRequestCountPerTarget"
//      resource_label         = "${module.lb.this_lb_arn_suffix}/${module.lb.target_group_arn_suffixes[2]}"
//    }
//
//    target_value       = 30
//    scale_in_cooldown  = 300
//    scale_out_cooldown = 120
//    disable_scale_in   = false
//  }
//}
