resource "aws_sns_topic" "budget_topic" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.budget_topic.arn
  protocol  = "email"
  endpoint  = var.email
}

resource "aws_budgets_budget" "this" {
  name              = var.name
  budget_type       = var.budget_type
  limit_amount      = var.limit_amount
  limit_unit        = var.limit_unit
  time_unit         = var.time_unit

  notification {
    comparison_operator        = var.comparison_operator
    threshold                  = var.threshold
    threshold_type             = var.threshold_type
    notification_type          = var.notification_type
    subscriber_sns_topic_arns  = [aws_sns_topic.budget_topic.arn]
  }
}

# Lambda Function to handle budget alerts

# --- Crear ZIP con el código de la Lambda ---
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

# --- Rol IAM para Lambda ---
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_budget_email_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# --- Políticas necesarias ---
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_ses_policy" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSESFullAccess"
}

# --- Crear Lambda Function ---
resource "aws_lambda_function" "budget_email_lambda" {
  function_name = "budget_email_notifier"
  role          = aws_iam_role.lambda_exec_role.arn
  runtime       = "python3.9"
  handler       = "lambda_function.lambda_handler"
  filename      = data.archive_file.lambda_zip.output_path

  environment {
    variables = {
      FROM_EMAIL = var.from_email
      TO_EMAIL   = var.to_email
      SLACK_WEBHOOK_URL = var.slack_webhook_url   # 👈 En mayúsculas
      SLACK_CHANNEL     = var.slack_channel    # Canal de Slack donde podria mandar las notificaciones
    }
  }
}

# --- Permitir a SNS invocar la Lambda ---
resource "aws_lambda_permission" "allow_sns_invoke" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.budget_email_lambda.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.budget_topic.arn
}

# --- Suscribir la Lambda al Topic SNS ---
resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.budget_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.budget_email_lambda.arn
}
