output "sqs_failure_destination_arn" {
    value = aws_sqs_queue.terraform_queue.arn
}
