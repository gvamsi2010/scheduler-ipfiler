data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}


resource "aws_iam_policy" "cloudwatch_logs_policy" {
  name        = "cloudwatch_logs_policy"
  description = "Allows writing logs to CloudWatch Logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/IP_prefix:*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "cloudwatch_logs_attachment" {
  name       = "cloudwatch_logs_attachment"
  roles      = [aws_iam_role.iam_for_lambda.name]
  policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
}


data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "IP_prefix" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "IP_prefix"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  source_code_hash = data.archive_file.lambda.output_base64sha256

}


resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  name                = "lambda_schedule_rule"
  //schedule_expression = "cron(0 5 * * ? *)" // Schedule expression, trigger daily at 12 AM EST
  schedule_expression = "rate(1 minute)" // Schedule expression, trigger every minute
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_schedule.name
  target_id = "lambda_target"
  arn       = aws_lambda_function.IP_prefix.arn
}