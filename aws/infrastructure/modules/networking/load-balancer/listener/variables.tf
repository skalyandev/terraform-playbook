#########################################################
# LISTENERS
#########################################################
variable "listeners" {

  description = "Load Balancer Listeners"

  type = map(object({

    load_balancer = string

    port     = number
    protocol = string

    certificate_arn = optional(string)

    ssl_policy = optional(string)

    default_action = object({

      type         = string
      target_group = optional(string)

      redirect = optional(object({

        port        = string
        protocol    = string
        status_code = string

      }))

    })

  }))

}


#########################################################
# LOAD BALANCER ARNS
#########################################################

variable "load_balancer_arns" {

  description = "Map of ALB ARNs"

  type = map(string)

}

#########################################################
# TARGET GROUP ARNS
#########################################################

variable "target_group_arns" {

  description = "Map of Target Group ARNs"

  type = map(string)

}

