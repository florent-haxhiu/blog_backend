def set_up_mock_dynamodb(resource) -> None:
    resource.create_table(
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
        ]
    )