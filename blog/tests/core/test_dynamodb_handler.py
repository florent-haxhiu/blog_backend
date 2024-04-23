import unittest

import boto3
import moto

from core.dynamodb_handler import DynamoDbHandler


@moto.mock_dynamodb
class TestDynamoDbHandler(unittest.TestCase):

    def setUp(self) -> None:
        self._mock_dynamodb = boto3.resource('dynamodb')
        self._mock_dynamodb.create_table(
            TableName='blogs',
            KeySchema=[
                {
                    'AttributeName': 'blogId',
                    'KeyType': 'HASH'
                }
            ],
            AttributeDefinitions=[
                {
                    'AttributeName': 'blogId',
                    'AttributeType': 'S'
                }
            ],
            ProvisionedThroughput={
                'ReadCapacityUnits': 5,
                'WriteCapacityUnits': 5
            }
        )
        self._target = DynamoDbHandler(
            table=self._mock_dynamodb.Table('blogs')
        )

    def test_table_count(self):
        expected = 0

        self.assertEqual(expected, self._mock_dynamodb.Table('blogs').item_count)


    def test_saves_blog_to_db_with_incremental_ids(self):
        pass