

class DynamoDbHandler:

    def __init__(self, client: DynamoDBClient) -> None:
        self._dynamodb = client
