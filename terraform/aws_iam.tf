/*
 *  Lambda Permission to be invoked from API Gateway
 */

resource "aws_lambda_permission" "blog_backend" {
  depends_on = [
    aws_lambda_function.blog_handler,
    aws_api_gateway_rest_api.blog_api
  ]
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.blog_handler.function_name
  principal     = "apigateway.amazonaws.com"
}

resource "aws_lambda_permission" "blog_api_gateway_method" {
  depends_on = [
    aws_lambda_function.blog_handler,
    aws_api_gateway_rest_api.blog_api
  ]
  statement_id  = "AllowExecutionFromAPIGatewayMethod"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.blog_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.blog_api.id}/*/*"
}

/*
 *  IAM Role for lambda
 */
resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_policy.json
}

/*
 *  IAM Role for API Gateway
 */
resource "aws_iam_role" "api-gw_role" {
  name               = "api-gw_role"
  assume_role_policy = data.aws_iam_policy_document.api_assume_policy.json
}

/*
 *  IAM Policy attachment for Lambda logging
 */
resource "aws_iam_role_policy_attachment" "lambda_logs_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
}

/*
 * IAM Policy attachment for API logging
 */
resource "aws_iam_role_policy_attachment" "api_logs_attachment" {
  role       = aws_iam_role.api-gw_role.name
  policy_arn = aws_iam_policy.api_logs_policy.arn
}

/*
 * IAM Policy for Lambda logging
 */
resource "aws_iam_policy" "cloudwatch_logs_policy" {
  name   = "iam_policy_for_blog_handler_lambda"
  policy = data.aws_iam_policy_document.logs_policy.json
}

/*
 * IAM Policy for API logging
 */
resource "aws_iam_policy" "api_logs_policy" {
  name   = "iam_policy_for_api_gateway"
  policy = data.aws_iam_policy_document.logs_policy.json
}

/*
 *  IAM Policy Document for logging
 */
data "aws_iam_policy_document" "logs_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
    effect    = "Allow"
  }
}

/*
 *  IAM Policy Document for Lambda assuming Lambda privileges
 */
data "aws_iam_policy_document" "lambda_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "api_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["apigateway.amazonaws.com"]
      type        = "Service"
    }
  }
}
