resource "aws_api_gateway_rest_api" "api_rest" {
  name = "${var.application_name}-api"
}

resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_rest.id
  parent_id   = aws_api_gateway_rest_api.api_rest.root_resource_id
  path_part   = "lambda"
}

resource "aws_api_gateway_method" "api_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_rest.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_integration" {
  rest_api_id = aws_api_gateway_rest_api.api_rest.id
  resource_id = aws_api_gateway_resource.api_resource.id
  http_method = aws_api_gateway_method.api_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_api.invoke_arn
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [aws_api_gateway_method.api_method, aws_api_gateway_integration.api_integration]

  rest_api_id = aws_api_gateway_rest_api.api_rest.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api_rest.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_rest.id
  stage_name    = "dev"
}