resource "aws_iam_role_policy" "policy-access-s3-env-bucket" {
  name = "policy-access-s3-env-bucket"
  role = aws_iam_role.role-ecs-to-s3.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:GetBucketLocation"
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

resource "aws_iam_role" "role-ecs-to-s3" {
  name = "role-ecs-to-s3"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs.amazonaws.com"
        }
      },
    ]
  })
}
