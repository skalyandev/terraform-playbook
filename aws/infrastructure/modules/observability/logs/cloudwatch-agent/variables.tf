#########################################################
# CLOUDWATCH AGENTS
#########################################################

variable "cloudwatch_agents" {

  description = "CloudWatch Agent configuration"

  type = map(object({

    instance_id = string

    config_name = string

    ssm_parameter_name = optional(string)

    mode = optional(string, "ec2")

    restart = optional(bool, true)

    install_agent = optional(bool, true)

    parameters = optional(map(string), {})

    tags = optional(map(string), {})
  }))
}


#########################################################
# COMMON TAGS
#########################################################

variable "tags" {

  description = "Common tags"

  type = map(string)

  default = {}
}
