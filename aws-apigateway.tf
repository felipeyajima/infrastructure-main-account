resource "aws_api_gateway_rest_api" "main" {
  name = "main"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "turnon" {
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "turnon"
  rest_api_id = aws_api_gateway_rest_api.main.id
}

resource "aws_api_gateway_method" "post-turnon" {
  authorization = "NONE"
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.turnon.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
}

resource "aws_api_gateway_integration" "to-batch" {
  http_method = aws_api_gateway_method.post-turnon.http_method
  resource_id = aws_api_gateway_resource.turnon.id
  rest_api_id = aws_api_gateway_rest_api.main.id
  type        = "AWS"
  integration_http_method = "POST"
  uri = "arn:aws:apigateway:sa-east-1:batch:path/v1/submitjob"
  credentials = aws_iam_role.portfolio-role-apigtw-to-services.arn
  request_templates = {                  # Not documented
    "application/json" = "${file("api_gateway_body_mapping.template")}"
  }
}


