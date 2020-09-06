resource "aws_lb_listener_rule" "api_calculator" {
  listener_arn = module.lb.https_listener_arns[0]

  action {
    type             = "forward"
    target_group_arn = module.lb.target_group_arns[0]
  }

  condition {
    path_pattern {
      values = ["/calculator/*"]
    }
  }
}

resource "aws_ecs_service" "api_calculator" {
  name    = "api-calculator"
  cluster = aws_ecs_cluster.main.id

  task_definition = aws_ecs_task_definition.api_calculator.arn

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  desired_count                      = 0

  load_balancer {
    target_group_arn = module.lb.target_group_arns[0]
    container_name   = "service"
    container_port   = 5000
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

resource "aws_ecs_task_definition" "api_calculator" {
  family = "api-calculator"

  network_mode       = "bridge"
  task_role_arn      = aws_iam_role.task.arn
  execution_role_arn = aws_iam_role.execution.arn

  container_definitions = <<-EOF
[
  ${module.ecs_container_definition_api_calculator.json_map_encoded}
]
EOF

  requires_compatibilities = ["EC2"]
}

module "ecs_container_definition_api_calculator" {
  source  = "cloudposse/ecs-container-definition/aws"
  version = "0.41.0"

  container_name               = "service"
  container_image              = "docker.pkg.github.com/fuxingloh/smu-goldman-hackathon/api-calculator:latest"
  container_memory_reservation = 256

  essential = true

  port_mappings = [
    {
      hostPort      = 0
      containerPort = 5000
      protocol      = "tcp"
    }
  ]

  environment = []

  log_configuration = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = local.awslogs.group
      awslogs-region        = local.awslogs.region
      awslogs-stream-prefix = "api-calculator"
    }
  }

  repository_credentials = {
    credentialsParameter = aws_secretsmanager_secret.github_token.arn
  }
}

resource "aws_appautoscaling_target" "api_calculator" {
  min_capacity = 1
  max_capacity = 5

  resource_id = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.api_calculator.name}"

  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

//resource "aws_appautoscaling_policy" "api_calculator" {
//  name        = "ecs_cluster_api_calculator"
//  policy_type = "TargetTrackingScaling"
//
//  resource_id        = aws_appautoscaling_target.api_calculator.resource_id
//  scalable_dimension = aws_appautoscaling_target.api_calculator.scalable_dimension
//  service_namespace  = aws_appautoscaling_target.api_calculator.service_namespace
//
//  target_tracking_scaling_policy_configuration {
//    predefined_metric_specification {
//      predefined_metric_type = "ALBRequestCountPerTarget"
//      resource_label         = "${module.lb.this_lb_arn_suffix}/${module.lb.target_group_arn_suffixes[0]}"
//    }
//
//    target_value       = 30
//    scale_in_cooldown  = 300
//    scale_out_cooldown = 120
//    disable_scale_in   = false
//  }
//}

