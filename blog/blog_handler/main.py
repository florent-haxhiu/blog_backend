import aws_lambda_powertools

logger = aws_lambda_powertools.Logger()


def lambda_handler(event, context):
    logger.info(event)
    return {
            'message': 'boo'
    }
