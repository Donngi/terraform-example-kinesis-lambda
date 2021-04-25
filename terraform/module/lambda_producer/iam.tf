resource "aws_iam_role" "lambda_producer" {
  name = "LambdaRoleForKinesisProducer"

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
  role       = aws_iam_role.lambda_producer.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "lambda_xray" {
  name        = "LambdaProducerXrayWriteOnlyPolicy"
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
  role       = aws_iam_role.lambda_producer.name
  policy_arn = aws_iam_policy.lambda_xray.arn
}

resource "aws_iam_policy" "lambda_kinesis_producer" {
  name        = "LambdaKinesisProducerPolicy"
  description = "Allow lambda to access to specific kinesis data streams"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "kinesis:PutRecord"
        ]
        Effect   = "Allow"
        Resource = var.kinesis_stream_arn
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_kinesis_producer" {
  role       = aws_iam_role.lambda_producer.name
  policy_arn = aws_iam_policy.lambda_kinesis_producer.arn
}
