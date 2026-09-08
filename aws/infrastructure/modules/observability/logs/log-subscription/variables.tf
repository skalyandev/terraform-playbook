#########################################################
# CLOUDWATCH LOG SUBSCRIPTIONS
#########################################################

variable "log_subscriptions" {

  description = "CloudWatch Log Group subscription filter configurations."

  type = map(object({

    #####################################################
    # SOURCE
    #####################################################

    log_group_name = string

    #####################################################
    # FILTER
    #####################################################

    filter_name = optional(string)

    filter_pattern = optional(string, "")

    #####################################################
    # DESTINATION
    #####################################################

    destination_arn = string

    #####################################################
    # OPTIONAL
    #####################################################

    distribution = optional(string)

  }))

}

#########################################################
# TAGS
#########################################################

variable "tags" {

  description = "Common tags."

  type = map(string)

  default = {}

}
