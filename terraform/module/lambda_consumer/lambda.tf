data "archive_file" "consumer" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/upload/lambda.zip"
}

resource "aws_lambda_function" "consumer" {
  filename      = data.archive_file.consumer.output_path
  function_name = "SampleLambdaKinesisConsumer"
  role          = aws_iam_role.lambda_consumer.arn
  handler       = "main.lambda_handler"

  source_code_hash = data.archive_file.consumer.output_base64sha256

  runtime = "python3.8"

  tracing_config {
    mode = "Active"
  }

  timeout = 30
}

resource "aws_lambda_event_source_mapping" "consumer" {
  event_source_arn       = var.kinesis_stream_arn
  function_name          = aws_lambda_function.consumer.arn
  starting_position      = "TRIM_HORIZON"
  parallelization_factor = 10
  maximum_retry_attempts = 2
  destination_config {
    on_failure {
      destination_arn = var.sqs_failure_destination_arn
    }
  }
}


