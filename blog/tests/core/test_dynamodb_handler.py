import unittest
from unittest.mock import Mock

from core.dynamodb_handler import DynamoDbHandler


class TestDynamoDbHandler(unittest.TestCase):

    def setUp(self) -> None:
        self._mock_dynamodb = Mock()
        self._target = DynamoDbHandler(
            client=self._mock_dynamodb
        )
