import logging

def lambda_handler(event, context):
    # Simply show event data.
    logger = logging.getLogger()
    logger.setLevel('INFO')
    logger.info('event: {}'.format(event))
    