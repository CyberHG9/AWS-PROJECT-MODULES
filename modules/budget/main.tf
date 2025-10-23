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
