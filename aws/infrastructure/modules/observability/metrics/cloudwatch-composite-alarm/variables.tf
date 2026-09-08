#########################################################
# CLOUDWATCH COMPOSITE ALARMS
#########################################################

variable "composite_alarms" {

  description = "Map of CloudWatch Composite Alarm definitions."

  type = map(object({

    #####################################################
    # Alarm
    #####################################################

    alarm_name        = string

    alarm_description = optional(string)

    #####################################################
    # Alarm Rule
    #####################################################

    alarm_rule = string

    #####################################################
    # Actions
    #####################################################

    actions_enabled = optional(bool, true)

    #####################################################
    # Notifications
    #####################################################

    sns_topic = optional(string)

  }))

  validation {

    condition = length(var.composite_alarms) > 0

    error_message = "At least one CloudWatch Composite Alarm must be defined."

  }

}

#########################################################
# SNS TOPIC ARNS
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

  description = "Common tags."

  type = map(string)

  default = {}

}
