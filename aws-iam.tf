resource "aws_iam_policy" "policy-access-s3-vars" {
  name        = "access-s3-vars"
  path        = "/"
  description = "Acesso aos arquivos de variaveis do ECS no S3"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
