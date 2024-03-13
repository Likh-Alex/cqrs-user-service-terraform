resource "aws_s3_bucket" "user_service_jars_bucket" {
  bucket = "user-cqrs-service-lambda-jars-dev" # var

  tags = {
    Name        = "user-cqrs-service-lambda-jars-dev" # var
    Environment = "Dev" # var
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.user_service_jars_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}