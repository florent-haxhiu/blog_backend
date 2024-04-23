resource "aws_dynamodb_table" "blogs" {
  name     = "blogs"
  hash_key = "blogId"

  attribute {
    name = "blogId"
    type = "S"
  }
}
