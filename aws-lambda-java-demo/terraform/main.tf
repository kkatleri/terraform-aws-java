provider "aws" {
  region = "us-east-1"
}

locals {
  app_jar_location = "../dist/aws-lambda-java-demo-1.0-SNAPSHOT.jar"
}

resource "aws_lambda_function" "demo_java_terraform_lambda" {
  function_name    = "aws-lambda-java-terraform-demo"
  runtime          = "java11"
  handler          = "com.autobots.function.TerraformDemoFunction::handleRequest"
  memory_size      = 128
  timeout          = 10
  filename         = "${local.app_jar_location}"
  source_code_hash = filebase64sha256("${local.app_jar_location}")
  role             = aws_iam_role.lambda_exec.arn
}

resource "aws_iam_role" "lambda_exec" {
  name = "my-lambda-exec-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
