data "archive_file" "producer" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/upload/lambda.zip"
}

resource "aws_lambda_function" "producer" {
  filename      = data.archive_file.producer.output_path
  function_name = "SampleLambdaKinesisProducer"
  role          = aws_iam_role.lambda_producer.arn
  handler       = "main.lambda_handler"

  source_code_hash = data.archive_file.producer.output_base64sha256

  runtime = "python3.8"

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      TARGET_KINESIS_STREAM_NAME = var.kinesis_stream_name
    }
  }

  timeout = 30
}

