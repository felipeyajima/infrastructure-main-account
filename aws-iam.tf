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
          "s3:GetObject",
          "s3:GetBucketLocation",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ssm:GetParameters",
          "secretsmanager:GetSecretValue",
          "kms:Decrypt"
        ]
        Effect   = "Allow"
        Resource = aws_s3_bucket.env-vars-ecs-yajima.arn
      },
    ]
  })
  depends_on = [
     aws_s3_bucket.env-vars-ecs-yajima
  ]
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
            "ecs.amazonaws.com"
          ]
        }
      },
    ]
  })
}
