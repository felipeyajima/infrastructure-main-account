
resource "aws_batch_compute_environment" "turnon" {
  compute_environment_name = "turnon"

  compute_resources {
    max_vcpus = 2

    security_group_ids = [
      aws_security_group.allow_internet_turnon.id
    ]

    subnets = [
      aws_subnet.public_sn.id
    ]

    type = "FARGATE"
  }

  service_role = aws_iam_role.role-ecs-to-services.arn
  type         = "MANAGED"
}



resource "aws_batch_job_queue" "turnon" {
  name     = "turnon"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    aws_batch_compute_environment.turnon.arn
  ]
}

