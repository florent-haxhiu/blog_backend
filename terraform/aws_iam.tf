resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_policy.json
}

resource "aws_iam_role" "api-gw_role" {
  name               = "api-gw_role"
  assume_role_policy = data.aws_iam_policy_document.api_assume_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_logs_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
}

resource "aws_iam_role_policy_attachment" "api_invoke_attachment" {
  role       = aws_iam_role.api-gw_role.name
  policy_arn = aws_iam_policy.api_invoke_attachment.arn
}

resource "aws_iam_role_policy_attachment" "api_logs_attachment" {
  role       = aws_iam_role.api-gw_role.name
  policy_arn = aws_iam_policy.api_logs_policy.arn
}

resource "aws_iam_policy" "cloudwatch_logs_policy" {
  name   = "iam_policy_for_blog_handler_lambda"
  policy = data.aws_iam_policy_document.logs_policy.json
}

resource "aws_iam_policy" "api_invoke_attachment" {
  name   = "iam_policy_to_allow_api_to_invoke_lambda"
  policy = data.aws_iam_policy_document.api_invoke_function.json
}

resource "aws_iam_policy" "api_logs_policy" {
  name   = "iam_policy_for_api_gateway"
  policy = data.aws_iam_policy_document.logs_policy.json
}

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

data "aws_iam_policy_document" "api_invoke_function" {
  statement {
    actions   = ["lambda:InvokeFunction"]
    effect    = "Allow"
    resources = ["arn:aws:lambda:*:*:*"]
  }
}
