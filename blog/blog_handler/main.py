import aws_lambda_powertools

logger = aws_lambda_powertools.Logger()


def lambda_handler(event, context):
    logger.info('HELLO WORLD')
    return {
        'statusCode': 200,
        'message': 'Hello World'
    }
