variable "vpc_flow_logs" {

  type = map(object({

    vpc_id         = string
    log_group_name = string
    iam_role_arn   = string

    traffic_type             = optional(string, "ALL")
    max_aggregation_interval = optional(number, 600)

  }))

}

#########################################################
# TAGS
#########################################################

variable "tags" {

  description = "Common tags"

  type = map(string)

  default = {}

}
