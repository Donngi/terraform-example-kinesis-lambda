output "kinesis_stream_arn" {
  value = aws_kinesis_stream.sample.arn
}

output "kinesis_stream_name" {
  value = aws_kinesis_stream.sample.name
}
