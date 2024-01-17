resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/${var.application_name}-lambda-function"
  retention_in_days = 14
}