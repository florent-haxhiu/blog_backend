class DynamoDbHandler:

    def __init__(self, table) -> None:
        self._table = table

    def get_item_count(self):
        return self._table.item_count
