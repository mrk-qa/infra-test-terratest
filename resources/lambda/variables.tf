variable "region" {
  description = "Region of resources"
  type        = string
  default     = "us-east-1"
}

data "aws_caller_identity" "main" {}

variable "aws_account_id" {
  description = "Region of resources"
  type        = string
  default     = data.aws_caller_identity.main.account_id
}

variable "function_name" {
  description = "The name of the function to provision"
  type        = string
  default     = "api_lambda"
}

variable "application_name" {
  description = "Used to name resources provisioned by this template"
  type        = string
  default     = "terraform-and-terratest-aws"
}