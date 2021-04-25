resource "aws_kinesis_stream" "sample" {
  name        = "SampleStream"
  shard_count = 1
}
