resource "aws_lambda_function" "my_lambda" {
  function_name = "create-user-lambda"

  s3_bucket = aws_s3_bucket.user_service_jars_bucket.bucket       # Replace with your S3 bucket name
  s3_key    = "create-user-module-1.0-SNAPSHOT.jar"  # Replace with the S3 object key for your JAR file

  handler = "org.example.CreateUserCommandHandler" # Replace with the handler class name
  runtime = "java21"                # Or your Java runtime version

  role    = aws_iam_role.lambda_role.arn
  timeout = 60 # in seconds
}


resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

