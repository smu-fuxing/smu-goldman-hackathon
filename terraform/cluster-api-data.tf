resource "aws_lb_listener_rule" "api_data" {
  listener_arn = module.lb.https_listener_arns[0]

  action {
    type             = "forward"
    target_group_arn = module.lb.target_group_arns[1]
  }

  condition {
    path_pattern {
      values = ["/data/*"]
    }
  }
}

resource "aws_ecs_service" "api_data" {
  name    = "api-data"
  cluster = aws_ecs_cluster.main.id

  task_definition = aws_ecs_task_definition.api_data.arn

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  desired_count                      = 0

  load_balancer {
    target_group_arn = module.lb.target_group_arns[1]
    container_name   = "service"
    container_port   = 8000
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
    ignore_changes = [desired_count, task_definition]
  }
}

resource "aws_ecs_task_definition" "api_data" {
  family = "api-data"

  network_mode       = "bridge"
  task_role_arn      = aws_iam_role.task_role.arn
  execution_role_arn = aws_iam_role.execution_role.arn

  container_definitions = <<-EOF
[
  ${module.ecs_container_definition_api_data.json_map_encoded}
]
EOF

  requires_compatibilities = ["EC2"]

  lifecycle {
    // This will get edited by GitHub Actions
    ignore_changes = [container_definitions]
  }
}

module "ecs_container_definition_api_data" {
  source  = "cloudposse/ecs-container-definition/aws"
  version = "0.41.0"

  container_name               = "service"
  container_image              = "docker.pkg.github.com/fuxingloh/smu-goldman-hackathon/api-data:latest"
  container_memory_reservation = 256

  essential = true

  port_mappings = [
    {
      hostPort      = 0
      containerPort = 8000
      protocol      = "tcp"
    }
  ]

  environment = [
  ]

  log_configuration = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = local.awslogs.group
      awslogs-region        = local.awslogs.region
      awslogs-stream-prefix = "api-data"
    }
  }

  repository_credentials = {
    credentialsParameter = aws_secretsmanager_secret.github_token.arn
  }
}

resource "aws_appautoscaling_target" "api_data" {
  min_capacity = 2
  max_capacity = 5

  resource_id = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.api_data.name}"

  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "api_data" {
  name        = "ecs_cluster_api_data"
  policy_type = "TargetTrackingScaling"

  resource_id        = aws_appautoscaling_target.api_data.resource_id
  scalable_dimension = aws_appautoscaling_target.api_data.scalable_dimension
  service_namespace  = aws_appautoscaling_target.api_data.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${module.lb.this_lb_arn_suffix}/${module.lb.target_group_arn_suffixes[1]}"
    }

    target_value       = 30
    scale_in_cooldown  = 300
    scale_out_cooldown = 120
    disable_scale_in   = false
  }
}
