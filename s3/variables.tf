variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "with_policy" {
  description = "If set to `true`, the bucket will be created with a bucket policy."
  type        = bool
  default     = false
}

variable "tag_bucket_name" {
  description = "The Name tag to set for the S3 Bucket."
  type        = string
  default     = "Test Bucket"
}

variable "tag_bucket_environment" {
  description = "The Environment tag to set for the S3 Bucket."
  type        = string
  default     = "Test"
}