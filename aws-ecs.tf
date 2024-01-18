resource "aws_ecs_task_definition" "turnon" {
  family                   = "turnon"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "turnon",
    "image": "381500507201.dkr.ecr.sa-east-1.amazonaws.com/turnon:latest",
    "cpu": 1024,
    "memory": 2048,
    "essential": true
    #"environmentFiles": [
    #  {
    #    "value": "arn:aws:s3:::env-vars-ecs-yajima/ecs.env",
    #    "type": "s3"
    # }
    #]
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

