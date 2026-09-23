#########################################################
# COST ANOMALY DETECTION
#########################################################

variable "monitor_name" {
  description = "Name of the AWS Cost Anomaly Detection monitor."
  type        = string

  validation {
    condition     = trimspace(var.monitor_name) != ""
    error_message = "monitor_name must not be empty."
  }
}

variable "monitor_type" {
  description = "AWS Cost Anomaly Detection monitor type."
  type        = string
  default     = "DIMENSIONAL"

  validation {
    condition     = var.monitor_type == "DIMENSIONAL"
    error_message = "monitor_type must be DIMENSIONAL."
  }
}

variable "monitor_dimension" {
  description = "Cost dimension monitored by AWS Cost Anomaly Detection."
  type        = string
  default     = "SERVICE"

  validation {
    condition     = var.monitor_dimension == "SERVICE"
    error_message = "monitor_dimension must be SERVICE."
  }
}

variable "subscription_name" {
  description = "Name of the AWS Cost Anomaly Detection subscription."
  type        = string

  validation {
    condition     = trimspace(var.subscription_name) != ""
    error_message = "subscription_name must not be empty."
  }
}

variable "notification_frequency" {
  description = "Frequency for cost anomaly notifications."
  type        = string
  default     = "DAILY"

  validation {
    condition = contains(
      ["DAILY", "IMMEDIATE", "WEEKLY"],
      var.notification_frequency
    )

    error_message = "notification_frequency must be DAILY, IMMEDIATE, or WEEKLY."
  }
}

variable "absolute_threshold" {
  description = "Absolute anomaly impact threshold in USD."
  type        = number
  default     = 100

  validation {
    condition     = var.absolute_threshold >= 0
    error_message = "absolute_threshold must be zero or greater."
  }
}

variable "percentage_threshold" {
  description = "Percentage anomaly impact threshold."
  type        = number
  default     = 40

  validation {
    condition     = var.percentage_threshold >= 0
    error_message = "percentage_threshold must be zero or greater."
  }
}

variable "subscriber_email_addresses" {
  description = "Email addresses receiving cost anomaly notifications."
  type        = list(string)
  default     = []
}

variable "subscriber_sns_topic_arns" {
  description = "SNS topic ARNs receiving cost anomaly notifications."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Common tags applied to FinOps resources."
  type        = map(string)
  default     = {}
}


