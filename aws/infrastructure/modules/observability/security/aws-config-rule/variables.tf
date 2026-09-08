#########################################################
# AWS CONFIG RULES
#########################################################

variable "config_rules" {

  description = "AWS Config rule configurations."

  type = map(object({

    #####################################################
    # RULE NAME
    #####################################################

    name = optional(string)

    description = optional(string)

    #####################################################
    # RULE TYPE
    #####################################################

    source_identifier = string

    #####################################################
    # EVALUATION
    #####################################################

    maximum_execution_frequency = optional(string)

    #####################################################
    # INPUT PARAMETERS
    #####################################################

    input_parameters = optional(map(string), {})

    #####################################################
    # SCOPE
    #####################################################

    compliance_resource_types = optional(list(string), [])

    tag_key = optional(string)

    tag_value = optional(string)

    #####################################################
    # ENABLE / DISABLE
    #####################################################

    enabled = optional(bool, true)

    #####################################################
    # REMEDIATION
    #####################################################

    remediation_enabled = optional(bool, false)

    remediation_target_type = optional(string)

    remediation_target_id = optional(string)

    remediation_parameters = optional(map(string), {})

    automatic_remediation_attempts = optional(number)

    retry_attempt_seconds = optional(number)

  }))

  default = {}

}
