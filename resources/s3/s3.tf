# Deploy and configure test S3 bucket with versioning and access log
resource "aws_s3_bucket" "test_bucket" {
  bucket = "${local.aws_account_id}-${var.tag_bucket_name}"

  tags = {
    Name        = var.tag_bucket_name
    Environment = var.tag_bucket_environment
  }
}

resource "aws_s3_bucket_logging" "test_bucket" {
  bucket        = aws_s3_bucket.test_bucket.id
  target_bucket = aws_s3_bucket.test_bucket_logs.id
  target_prefix = "TFStateLogs/"
}

resource "aws_s3_bucket_versioning" "test_bucket" {
  bucket = aws_s3_bucket.test_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "test_bucket" {
  depends_on = [aws_s3_bucket.test_bucket]

  bucket = aws_s3_bucket.test_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "test_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.test_bucket]

  bucket = aws_s3_bucket.test_bucket.id
  acl    = "private"
}

# Deploy S3 bucket to collect access logs for test bucket
resource "aws_s3_bucket" "test_bucket_logs" {
  bucket = "${local.aws_account_id}-${var.tag_bucket_name}-logs"

  tags = {
    Name        = "${local.aws_account_id}-${var.tag_bucket_name}-logs"
    Environment = var.tag_bucket_environment
  }

  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "test_bucket_logs" {
  depends_on = [aws_s3_bucket.test_bucket_logs]

  bucket = aws_s3_bucket.test_bucket_logs.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "test_bucket_logs" {
  depends_on = [aws_s3_bucket_ownership_controls.test_bucket_logs]

  bucket = aws_s3_bucket.test_bucket_logs.id
  acl    = "log-delivery-write"
}