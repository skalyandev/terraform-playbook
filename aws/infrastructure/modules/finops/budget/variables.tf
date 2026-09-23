variable "budgets" {
  description = "Map of AWS cost budgets."

  type = map(object({
    name         = string
    limit_amount = number
    limit_unit   = optional(string, "USD")
    time_unit    = optional(string, "MONTHLY")

    services = optional(list(string), [])

    tags = optional(map(list(string)), {})

    actual_alerts = optional(list(object({
      threshold = number
    })), [
      {
        threshold = 50
      },
      {
        threshold = 80
      },
      {
        threshold = 100
      }
    ])

    forecast_alerts = optional(list(object({
      threshold = number
    })), [
      {
        threshold = 100
      }
    ])
  }))

  validation {
    condition = alltrue([
      for budget in var.budgets :
      budget.limit_amount > 0
    ])

    error_message = "Budget limit_amount must be greater than zero."
  }

  validation {
    condition = alltrue([
      for budget in var.budgets :
      contains(["MONTHLY", "QUARTERLY", "ANNUALLY"], budget.time_unit)
    ])

    error_message = "time_unit must be MONTHLY, QUARTERLY, or ANNUALLY."
  }
}

variable "notification_email_addresses" {
  description = "Email addresses receiving budget notifications."

  type    = list(string)
  default = []
}

variable "notification_sns_topic_arns" {
  description = "SNS topic ARNs receiving budget notifications."

  type    = list(string)
  default = []
}

variable "tags" {
  description = "Common tags applied to budget resources."

  type    = map(string)
  default = {}
}
