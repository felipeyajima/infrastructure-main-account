### Deprecated - Replaced by AWS Batch
/*
resource "aws_ecs_task_definition" "turnon" {
  family                   = "turnon"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  task_role_arn            = aws_iam_role.role-ecs-to-services.arn
  execution_role_arn       = aws_iam_role.role-ecs-to-services.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "turnon",
    "image": "381500507201.dkr.ecr.sa-east-1.amazonaws.com/turnon:latest",
    "cpu": 1024,
    "memory": 2048,
    "essential": true,
    "environment": [
      {
         "name": "URL_SANDBOX",
         "value": "${var.URL_SANDBOX}"
      },
      {
         "name": "USERNAME",
         "value": "${var.USERNAME}"
      },
      {
         "name": "PASSWORD",
         "value": "${var.PASSWORD}"
      },
      {
         "name": "TF_TOKEN",
         "value": "${var.TF_TOKEN}"
      },
      {
         "name": "TF_ACCESS_URL",
         "value": "${var.TF_ACCESS_URL}"
      },
      {
         "name": "TF_ACCESS_ID",
         "value": "${var.TF_ACCESS_ID}"
      },
      {
         "name": "TF_SECRET_URL",
         "value": "${var.TF_SECRET_URL}"
      },
      {
         "name": "TF_SECRET_ID",
         "value": "${var.TF_SECRET_ID}"
      },
      {
         "name": "QTD_SERVERS",
         "value": "${var.QTD_SERVERS}"
      }
   ]
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}


resource "aws_ecs_cluster" "this" {
  name = "main-ecs-cluster"
}

data "aws_ecs_task_execution" "turnon-task" {
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.turnon.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public_sn.id]
    security_groups  = [aws_security_group.allow_internet_turnon.id]
    assign_public_ip = true
  }

  depends_on = [
    aws_subnet.public_sn,
    aws_security_group.allow_internet_turnon
  ]
}
*/




