#########################################################
# SNS TOPIC ARNS
#########################################################

variable "topic_arns" {

  type = map(string)

}

#########################################################
# SUBSCRIPTIONS
#########################################################

variable "subscriptions" {

  type = map(object({

    topic    = string
    protocol = string
    endpoint = string

  }))

}
