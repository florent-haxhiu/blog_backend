resource "aws_dynamodb_table" "blogs" {
  name     = "blogs"
  hash_key = "blogId"

  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "blogId"
    type = "S"
  }
}
