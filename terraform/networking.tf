module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = "smu-goldman-hackathon"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-1a", "ap-southeast-1b"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
}

module "lb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [aws_security_group.cluster.id]

  target_groups = [
    {
      name_prefix      = "api-"
      backend_protocol = "HTTPS"
      backend_port     = 443
      target_type      = "instance"
      health_check = {
        enabled  = true
        interval = 30
        path     = "/_healthcheck"
        port     = "traffic-port"
        protocol = "HTTP"
      }
    },
    {
      name_prefix      = "data-"
      backend_protocol = "HTTPS"
      backend_port     = 443
      target_type      = "instance"
      health_check = {
        enabled  = true
        interval = 30
        path     = "/_healthcheck"
        port     = "traffic-port"
        protocol = "HTTP"
      }
    },
    {
      name_prefix      = "news-"
      backend_protocol = "HTTPS"
      backend_port     = 443
      target_type      = "instance"
      health_check = {
        enabled  = true
        interval = 30
        path     = "/_healthcheck"
        port     = "traffic-port"
        protocol = "HTTP"
      }
    }
  ]

  https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = aws_acm_certificate_validation.api_cert.certificate_arn
    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]
}

resource "aws_security_group" "cluster" {
  name   = "Cluster Networking"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      // SMU
      "156.146.57.0/24",
      // Home
      "103.6.151.0/24"
    ]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
