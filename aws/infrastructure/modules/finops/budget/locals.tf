locals {
  budget_notifications = {
    for notification in flatten([
      for budget_key, budget in var.budgets : concat(
        [
          for alert in budget.actual_alerts : {
            key                 = "${budget_key}-actual-${alert.threshold}"
            budget_key          = budget_key
            notification_type   = "ACTUAL"
            threshold           = alert.threshold
            comparison_operator = "GREATER_THAN"
          }
        ],
        [
          for alert in budget.forecast_alerts : {
            key                 = "${budget_key}-forecast-${alert.threshold}"
            budget_key          = budget_key
            notification_type   = "FORECASTED"
            threshold           = alert.threshold
            comparison_operator = "GREATER_THAN"
          }
        ]
      )
    ]) : notification.key => notification
  }
}
