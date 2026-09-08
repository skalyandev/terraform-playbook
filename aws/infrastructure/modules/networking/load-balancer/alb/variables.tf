#########################################################
# LOAD BALANCERS
#########################################################

variable "load_balancers" {

  description = "Application Load Balancer configuration"

  type = map(object({

    internal           = bool
    load_balancer_type = string

    security_groups = list(string)

    subnets = list(string)

    idle_timeout               = number
    enable_deletion_protection = bool
    enable_http2               = bool
    ip_address_type            = string

    tags = map(string)

  }))

}

#########################################################
# SUBNET IDS
#########################################################

variable "subnet_ids" {

  description = "Subnet lookup map"

  type = map(string)

}

#########################################################
# SECURITY GROUP IDS
#########################################################

variable "security_group_ids" {

  description = "Security Group lookup map"

  type = map(string)

}

#########################################################
# TAGS
#########################################################

variable "tags" {

  type = map(string)

}
