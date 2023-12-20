resource "aws_api_gateway_rest_api" "blog_api" {
  name = "blogAPI"
  body = jsonencode(templatefile("../interface/api.yaml", {
    blogHandlerARN  = aws_lambda_function.blog_handler.arn,
    region          = data.aws_region.current
  }))

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "blog_api" {
  rest_api_id = aws_api_gateway_rest_api.blog_api.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "blog_api" {
  deployment_id = aws_api_gateway_deployment.blog_api.id
  rest_api_id   = aws_api_gateway_rest_api.blog_api.id
  stage_name    = "master"
}
