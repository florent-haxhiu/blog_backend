resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_logs_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
}

resource "aws_iam_policy" "cloudwatch_logs_policy" {
  name   = "iam_policy_for_blog_handler_lambda"
  policy = data.aws_iam_policy_document.lambda_logs_policy.json
}

data "aws_iam_policy_document" "lambda_logs_policy" {
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
