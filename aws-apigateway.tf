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

