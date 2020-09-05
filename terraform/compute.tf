resource "aws_key_pair" "fuxing" {
  key_name   = "fuxing_transient"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC48Qa+x6OqaVmvQRZcl4yjpSQmsqzsYnXWy3WZgVvpuDnvQdkizh3vtqPoeVm5mCQJt7VG2VqkNOP0qJrSnrBzxDdKurCw+dCC9Tdvd0z4kHYMv2nX+BrIjETRRAwRuivV2+I3jJAZKc2+ZHeST3BcjyuBr7h44SDF0YTwrnBsyqLN3UnUzJR6m+5LLwpl2wpl8WhcJyaFtr7AXR/m3weNRvyRTlevI+YvvUm3k9mWJLtv4P3UEbBLIdoy7w+XiyD10d3CBU3JCp/vYV8WlH79GbqeoVRboaI7HaXJGLg85HuY2DicYYIKpbb87gn6Q9kRkYGX0DwACFJdoEapuQ9GGXif7L7V7NJAhSBwuRWdom4LoL81VHereqoUxEqv9OMTvBGCCbK+uavzFqVw/i4roUa/rRmlZnz8kNPpfVzdxOQy7n4uao84PdBqBWKqbB0T9QU5HZsoy7UGHa8We6+Fchds4meKCkrHJXIRZHdOKiQ/p1je5/3uIWR6NSckagc= fuxing_transient"
}

resource "aws_ecs_cluster" "main" {
  name = "Main Cluster"
}

// TODO(fuxing): https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/3.6.0
