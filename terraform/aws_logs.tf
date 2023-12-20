resource "aws_cloudwatch_log_group" "blog_api" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.blog_api.id}"
  retention_in_days = 7
}
