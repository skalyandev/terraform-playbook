#########################################################
# CLOUDWATCH METRIC ALARMS
#########################################################

variable "metric_alarms" {

  description = "Map of CloudWatch Metric Alarm definitions."

  type = map(object({

    #####################################################
    # Alarm
    #####################################################

    alarm_name        = string
    alarm_description = optional(string)

    #####################################################
    # Metric
    #####################################################

    namespace   = string
    metric_name = string

    dimensions = optional(map(string), {})

    #####################################################
    # Evaluation
    #####################################################

    comparison_operator = string
    evaluation_periods = number
    threshold = number
    period = number

    #####################################################
    # Statistics
    #####################################################

    statistic           = optional(string)
    extended_statistic  = optional(string)
    unit                = optional(string)

    #####################################################
    # Advanced
    #####################################################

    datapoints_to_alarm = optional(number)
    treat_missing_data  = optional(string, "missing")
    actions_enabled     = optional(bool, true)

    #####################################################
    # Notifications
    #####################################################

    sns_topic = optional(string)

  }))

  validation {

    condition = length(var.metric_alarms) > 0
    error_message = "At least one CloudWatch Metric Alarm must be defined."

  }

}

#########################################################
# SNS TOPICS
#########################################################

variable "sns_topic_arns" {

  description = "Map of SNS Topic ARNs."
  type = map(string)
  default = {}

}

#########################################################
# TAGS
#########################################################

variable "tags" {

  description = "Tags applied to all CloudWatch alarms."
  type = map(string)
  default = {}

}
