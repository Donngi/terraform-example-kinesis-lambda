module "kinesis" {
  source = "../../module/kinesis_data_streams"
}

module "lambda_producer" {
  source              = "../../module/lambda_producer"
  kinesis_stream_name = module.kinesis.kinesis_stream_name
  kinesis_stream_arn  = module.kinesis.kinesis_stream_arn
}

module "lambda_consumer" {
  source             = "../../module/lambda_consumer"
  kinesis_stream_arn = module.kinesis.kinesis_stream_arn
  sqs_failure_destination_arn = module.sqs_failure_destination.sqs_failure_destination_arn
} 

module "sqs_failure_destination" {
  source             = "../../module/sqs_failure_destination"
} 
