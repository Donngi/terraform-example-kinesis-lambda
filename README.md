# terraform-example-kinesis-lambda
Minimum example of kinesis datastreams and lambda

## Architecture
![Architecture](./doc/architecture.drawio.svg)

## Code structure
```
terraform
├── envs
│   └── example
│       ├── aws.tf
│       └── main.tf
└── module
    ├── kinesis_data_streams
    │   ├── kinesis.tf
    │   └── output.tf
    ├── lambda_consumer
    │   ├── iam.tf
    │   ├── lambda.tf
    │   ├── src
    │   │   └── main.py
    │   ├── upload
    │   │   └── lambda.zip
    │   └── vars.tf
    ├── lambda_producer
    │   ├── iam.tf
    │   ├── lambda.tf
    │   ├── src
    │   │   └── main.py
    │   ├── upload
    │   │   └── lambda.zip
    │   └── vars.tf
    └── sqs_failure_destination
        ├── output.tf
        └── sqs.tf
```
