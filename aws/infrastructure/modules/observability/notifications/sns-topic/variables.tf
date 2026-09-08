#########################################################
# SNS TOPICS
#########################################################

variable "topics" {

  description = "SNS Topics"

  type = map(object({

    display_name = optional(string)
    fifo_topic   = optional(bool, false)

  }))

}

#########################################################
# TAGS
#########################################################

variable "tags" {

  description = "Common Tags"

  type = map(string)

  default = {}

}
