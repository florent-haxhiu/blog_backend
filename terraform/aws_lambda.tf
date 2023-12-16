
resource "aws_lambda_function" "blog_handler" {
  function_name = "blog_lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  handler       = "blog.blog_handler.main.lambda_handler"
  timeout       = 10
  runtime       = "python3.11"
  filename      = aws_lambda_layer_version.lambda_layer.filename
  layers        = [aws_lambda_layer_version.lambda_layer.arn]
  depends_on    = [aws_iam_role_policy_attachment.lambda_logs_attachment]
}

resource "aws_lambda_layer_version" "lambda_layer" {
  layer_name = "blog_handler_packages"
  filename   = "./../artifact.zip"

  source_code_hash = filebase64sha256("./../artifact.zip")

  compatible_runtimes = ["python3.10", "python3.11"]
}