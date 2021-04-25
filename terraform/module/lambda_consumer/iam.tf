resource "aws_iam_role" "lambda_consumer" {
  name = "LambdaRoleForKinesisConsumer"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_consumer.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "lambda_xray" {
  name        = "LambdaConsumerXrayWriteOnlyPolicy"
  description = "Allow lambda to access to AWS X-Ray"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_xray" {
  role       = aws_iam_role.lambda_consumer.name
  policy_arn = aws_iam_policy.lambda_xray.arn
}

resource "aws_iam_policy" "lambda_kinesis_consumer" {
  name        = "LambdaKinesisConsumerPolicy"
  description = "Allow lambda to access to specific kinesis data streams"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "kinesis:GetRecords",
          "kinesis:GetShardIterator",
          "kinesis:DescribeStream"
        ]
        Effect   = "Allow"
        Resource = var.kinesis_stream_arn
      },
      {
        Action = [
          "kinesis:ListShards",
          "kinesis:ListStreams"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_kinesis_consumer" {
  role       = aws_iam_role.lambda_consumer.name
  policy_arn = aws_iam_policy.lambda_kinesis_consumer.arn
}

resource "aws_iam_policy" "lambda_send_sqs" {
  name        = "LambdaSQSSendMessagePolicy"
  description = "Allow lambda to access to specific kinesis data streams"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:SendMessage"
        ]
        Effect   = "Allow"
        Resource = var.sqs_failure_destination_arn
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_send_sqs" {
  role       = aws_iam_role.lambda_consumer.name
  policy_arn = aws_iam_policy.lambda_send_sqs.arn
}

