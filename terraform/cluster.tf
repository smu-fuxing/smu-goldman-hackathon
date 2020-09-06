resource "aws_ecs_cluster" "main" {
  name = "Mavis_GS_Cluster"
}

// TODO(fuxing): Update Desired Count = 0
// TODO(fuxing): Uncomment AAS Policy
