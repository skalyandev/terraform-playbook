resource "aws_budgets_budget" "this" {
  for_each = var.budgets

  name         = each.value.name
  budget_type  = "COST"
  limit_amount = tostring(each.value.limit_amount)
  limit_unit   = each.value.limit_unit
  time_unit    = each.value.time_unit

  dynamic "cost_filter" {
    for_each = length(each.value.services) > 0 ? [1] : []

    content {
      name   = "Service"
      values = each.value.services
    }
  }

  dynamic "cost_filter" {
    for_each = length(each.value.tags) > 0 ? [
      for tag_key, tag_values in each.value.tags : {
        key    = tag_key
        values = tag_values
      }
    ] : []

    content {
      name   = "TagKeyValue"
      values = [
        for value in cost_filter.value.values :
        "${cost_filter.value.key}$${value}"
      ]
    }
  }

  dynamic "notification" {
    for_each = {
      for key, notification in local.budget_notifications :
      key => notification
      if notification.budget_key == each.key
    }

    content {
      comparison_operator        = notification.value.comparison_operator
      threshold                  = notification.value.threshold
      threshold_type             = "PERCENTAGE"
      notification_type          = notification.value.notification_type
      subscriber_email_addresses = var.notification_email_addresses
      subscriber_sns_topic_arns  = var.notification_sns_topic_arns
    }
  }

  tags = merge(
    var.tags,
    {
      Name        = each.value.name
      ManagedBy   = "terraform"
      CostControl = "budget"
    }
  )
}
