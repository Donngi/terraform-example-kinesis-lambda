import logging

def lambda_handler(event, context):
    raise ValueError("error!")
    # Simply show event data.
    logger = logging.getLogger()
    logger.setLevel('INFO')
    logger.info('event: {}'.format(event))
    