provider "aws" {
  region = "eu-central-1"
}

resource "aws_lambda_function" "lambda_demo" {
  function_name = "lambda_demo"
  runtime = "java8"
  handler = "Hello::handleRequest"
  filename = "../../../target/aws-lambda-demo-1.0-SNAPSHOT-jar-with-dependencies.jar"
  role = "${aws_iam_role.lambda_exec_role.arn}"
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  description = "Execute Lambdas"
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