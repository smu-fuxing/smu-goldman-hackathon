resource "aws_key_pair" "fuxing" {
  key_name   = "fuxing_transient"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC48Qa+x6OqaVmvQRZcl4yjpSQmsqzsYnXWy3WZgVvpuDnvQdkizh3vtqPoeVm5mCQJt7VG2VqkNOP0qJrSnrBzxDdKurCw+dCC9Tdvd0z4kHYMv2nX+BrIjETRRAwRuivV2+I3jJAZKc2+ZHeST3BcjyuBr7h44SDF0YTwrnBsyqLN3UnUzJR6m+5LLwpl2wpl8WhcJyaFtr7AXR/m3weNRvyRTlevI+YvvUm3k9mWJLtv4P3UEbBLIdoy7w+XiyD10d3CBU3JCp/vYV8WlH79GbqeoVRboaI7HaXJGLg85HuY2DicYYIKpbb87gn6Q9kRkYGX0DwACFJdoEapuQ9GGXif7L7V7NJAhSBwuRWdom4LoL81VHereqoUxEqv9OMTvBGCCbK+uavzFqVw/i4roUa/rRmlZnz8kNPpfVzdxOQy7n4uao84PdBqBWKqbB0T9QU5HZsoy7UGHa8We6+Fchds4meKCkrHJXIRZHdOKiQ/p1je5/3uIWR6NSckagc= fuxing_transient"
}

data "aws_ssm_parameter" "ecs_optimized_ami" {
  // https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

module "asg_mavis" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name    = "MAVIS"
  lc_name = "MAVIS_LC"

  image_id             = data.aws_ssm_parameter.ecs_optimized_ami.value
  instance_type        = "t2.micro"
  security_groups      = [aws_security_group.cluster.id]
  iam_instance_profile = aws_iam_instance_profile.ecs.name

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

  min_size                  = 1
  max_size                  = 4
  desired_capacity          = 2
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Name"
      value               = "MAVIS t2.micro"
      propagate_at_launch = true
    }
  ]
}

resource "aws_autoscaling_policy" "asg_mavis" {
  name = "MAVIS_AS_POLICY"

  autoscaling_group_name = module.asg_mavis.this_autoscaling_group_name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 20.0
  }
}
