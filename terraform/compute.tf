resource "aws_key_pair" "fuxing" {
  key_name   = "fuxing_transient"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC48Qa+x6OqaVmvQRZcl4yjpSQmsqzsYnXWy3WZgVvpuDnvQdkizh3vtqPoeVm5mCQJt7VG2VqkNOP0qJrSnrBzxDdKurCw+dCC9Tdvd0z4kHYMv2nX+BrIjETRRAwRuivV2+I3jJAZKc2+ZHeST3BcjyuBr7h44SDF0YTwrnBsyqLN3UnUzJR6m+5LLwpl2wpl8WhcJyaFtr7AXR/m3weNRvyRTlevI+YvvUm3k9mWJLtv4P3UEbBLIdoy7w+XiyD10d3CBU3JCp/vYV8WlH79GbqeoVRboaI7HaXJGLg85HuY2DicYYIKpbb87gn6Q9kRkYGX0DwACFJdoEapuQ9GGXif7L7V7NJAhSBwuRWdom4LoL81VHereqoUxEqv9OMTvBGCCbK+uavzFqVw/i4roUa/rRmlZnz8kNPpfVzdxOQy7n4uao84PdBqBWKqbB0T9QU5HZsoy7UGHa8We6+Fchds4meKCkrHJXIRZHdOKiQ/p1je5/3uIWR6NSckagc= fuxing_transient"
}

data "aws_ssm_parameter" "ecs_optimized_ami" {
  // https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_iam_instance_profile" "asg_mavis" {
  name = "ECS_INSTANCE_PROFILE"
  role = aws_iam_role.asg_mavis.name
}

resource "aws_iam_role" "asg_mavis" {
  name = "ECS_INSTANCE_PROFILE_ROLE"
  path = "/"

  assume_role_policy = data.aws_iam_policy_document.asg_mavis.json
}

data "aws_iam_policy_document" "asg_mavis" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy_attachment" "asg_mavis" {
  name       = "ASG_MAVIS_ECS_ATTACHMENT"
  roles      = [aws_iam_role.asg_mavis.name]
  policy_arn = aws_iam_policy.asg_mavis_instance.arn
}

resource "aws_iam_policy" "asg_mavis_instance" {
  name = "ASG_MAVIS_ECS_POLICY"

  policy = data.aws_iam_policy_document.asg_mavis_instance.json
}


data "aws_iam_policy_document" "asg_mavis_instance" {
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
}



module "asg_mavis" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name    = "MAVIS t2.micro"
  lc_name = "MAVIS_LC"

  image_id             = data.aws_ssm_parameter.ecs_optimized_ami.value
  instance_type        = "t2.micro"
  security_groups      = [aws_security_group.cluster.id]
  iam_instance_profile = aws_iam_instance_profile.asg_mavis.name

  user_data = <<-EOF
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
echo ECS_ENABLE_AWSLOGS_EXECUTIONROLE_OVERRIDE=true >> /etc/ecs/ecs.config
EOF

  root_block_device = [
    {
      volume_size = "30"
      volume_type = "gp2"
    }
  ]

  asg_name            = "MAVIS_ASG"
  vpc_zone_identifier = module.vpc.private_subnets
  health_check_type   = "EC2"

  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
}

resource "aws_autoscaling_policy" "asg_mavis" {
  name = "MAVIS_AS_POLICY"

  autoscaling_group_name = module.asg_mavis.this_autoscaling_group_name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }
}
