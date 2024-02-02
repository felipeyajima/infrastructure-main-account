resource "aws_iam_role_policy" "policy-access-services" {
  name = "policy-access-s3-env-bucket"
  role = aws_iam_role.role-ecs-to-services.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ssm:GetParameters",
          "secretsmanager:GetSecretValue",
          "kms:Decrypt",
          "logs:DescribeLogGroups",
          "iam:GetInstanceProfile",
          "iam:GetRole",
          "autoscaling:*",
          "eks:*",
          "ecs:*",
          "ec2:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "role-ecs-to-services" {
  name = "role-ecs-to-s3"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "ecs-tasks.amazonaws.com",
            "ecs.amazonaws.com",
            "batch.amazonaws.com"
          ]
        }
      },
    ]
  })
}



### API Gateway -> Batch e ECS ###
resource "aws_iam_role_policy" "to-batch-e-ecs" {
  name = "portfolio-to-batch-e-ecs"
  role = aws_iam_role.portfolio-role-apigtw-to-services.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:*",
          "batch:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "portfolio-role-apigtw-to-services" {
  name = "portfolio-role-apigtw-to-services"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "apigateway.amazonaws.com"
          ]
        }
      },
    ]
  })
}



############## Permitindo que a role de execução do cluster tenha todas as permissões necessárias para um AWS Batch (AWSBatchServiceRole)
resource "aws_iam_role_policy_attachment" "copy-awsbatchrole" {
  role       = aws_iam_role.role-ecs-to-services.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}
