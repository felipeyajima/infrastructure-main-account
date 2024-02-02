
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


resource "aws_batch_job_definition" "turnon" {
  name = "turnon"
  type = "container"
  platform_capabilities = [
      "FARGATE"
  ]
  containerOrchestrationType = "ECS"
  timeout = {
    attemptDurationSeconds = 240
  }
  container_properties = jsonencode({
    image   = "381500507201.dkr.ecr.sa-east-1.amazonaws.com/turnon:latest"
    executionRoleArn = aws_iam_role.role-ecs-to-services.arn
    resourceRequirements = [
      {
        type  = "VCPU"
        value = "1"
      },
      {
        type  = "MEMORY"
        value = "2048"
      }
    ]

    fargatePlatformConfiguration = {
      platformVersion = "LATEST"
    }

    runtimePlatform = {
      operatingSystemFamily = "LINUX",
      cpuArchitecture = "X86_64"
    }

    networkConfiguration = {
        assignPublicIp = "ENABLED"
    }

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
  

  })
}
