#########################################################
# TARGET GROUPS
#########################################################

variable "target_groups" {

  description = "Application Load Balancer Target Groups"

  type = map(object({

    #####################################################
    # Target Group
    #####################################################

    vpc         = string
    port        = number
    protocol    = string
    target_type = string

    #####################################################
    # Optional
    #####################################################

    deregistration_delay      = optional(number, 300)
    load_balancing_algorithm  = optional(string, "round_robin")

    #####################################################
    # Health Check
    #####################################################

    health_check = object({

      enabled             = bool
      protocol            = string
      path                = string
      port                = string
      interval            = number
      timeout             = number
      healthy_threshold   = number
      unhealthy_threshold = number
      matcher             = string

    })

  }))

}

#########################################################
# VPC IDs
#########################################################

variable "vpc_id" {

  description = "VPC IDs"

  type = string

}

#########################################################
# TAGS
#########################################################

variable "tags" {

  description = "Common Tags"

  type = map(string)

  default = {}

}
