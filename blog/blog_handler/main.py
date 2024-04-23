from typing import Dict, Union
import json
import boto3
import aws_lambda_powertools
import aws_lambda_powertools.utilities.typing as aws_types

from core.dynamodb_handler import DynamoDbHandler
from core.models import BlogModel

logger = aws_lambda_powertools.Logger()


def lambda_handler(context: aws_types.LambdaContext, event: Dict[str, str]) -> Dict[str, Union[str, int]]:
    logger.info('Received ', event['body'])
    body: BlogModel = json.loads(event['body'])

    dynamodb_client = boto3.client('dynamodb')

    handler = DynamoDbHandler(client=dynamodb_client)

    return {
        'statusCode': 200,
        'body': json.dumps({'hello': 'world'})
    }
