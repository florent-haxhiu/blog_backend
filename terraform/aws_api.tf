resource "aws_api_gateway_rest_api" "blog_api" {
  name = "blogAPI"
  body = templatefile("../interface/api.yaml", {
    blogHandlerARN = aws_lambda_function.blog_handler.arn,
    region         = var.aws_region
  })

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

resource "aws_api_gateway_method_settings" "blog_api" {
  rest_api_id = aws_api_gateway_rest_api.blog_api.id
  stage_name  = aws_api_gateway_stage.blog_api.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

resource "aws_api_gateway_stage" "blog_api" {
  depends_on = [aws_cloudwatch_log_group.blog_api]

  deployment_id        = aws_api_gateway_deployment.blog_api.id
  rest_api_id          = aws_api_gateway_rest_api.blog_api.id
  stage_name           = "master"
  xray_tracing_enabled = true
}

resource "aws_api_gateway_rest_api_policy" "blog_api" {
  rest_api_id = aws_api_gateway_rest_api.blog_api.id
  policy      = data.aws_iam_policy_document.api_assume_policy.json
}
