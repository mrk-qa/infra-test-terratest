resource "aws_lambda_function" "lambda_api" {
  depends_on = [aws_iam_role_policy_attachment.lambda_logs, aws_cloudwatch_log_group.example]

  function_name = "${var.application_name}-lambda-function"
  handler       = "main.lambda_handler"
  runtime       = "python3.9"
  filename      = "src/main.zip"
  role          = aws_iam_role.lambda_role.arn

  source_code_hash = filebase64sha256("src/main.zip")
}

data "aws_caller_identity" "main" {}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_api.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.main.account_id}:${aws_api_gateway_rest_api.api_rest.id}/*/${aws_api_gateway_method.api_method.http_method}${aws_api_gateway_resource.api_resource.path}"
}