import os
import boto3
import logging


def lambda_handler(event, context):
    # Simply put event data to kinesis data streams.
    logger = logging.getLogger()
    logger.setLevel('INFO')
    logger.info('event: {}'.format(event))

    try:
        client = boto3.client('kinesis')
        response = client.put_record(
            Data=event,
            PartitionKey='123',
            StreamName=os.environ.get('TARGET_KINESIS_STREAM_NAME')
        )
        logger.info('response: {}'.format(response))
    except Exception as e:
        logger.error('error: {}'.format(e))
