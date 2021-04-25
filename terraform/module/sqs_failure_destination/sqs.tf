resource "aws_sqs_queue" "terraform_queue" {
  name                      = "SampleFailureDestinationQueue"
  max_message_size          = 2048
  message_retention_seconds = 6000
}
