#########################################################
# AWS CONFIG REMEDIATION
#########################################################

variable "remediations" {

  description = "AWS Config remediation configurations."

  type = map(object({

    #####################################################
    # CONFIG RULE
    #####################################################

    config_rule_name = string

    #####################################################
    # SSM AUTOMATION
    #####################################################

    target_type = optional( string,"SSM_DOCUMENT" )

    target_id = string

    target_version = optional(string)

    #####################################################
    # PARAMETERS
    #####################################################

    parameters = optional(
      map(object({
        static_value = optional(list(string))
        resource_value = optional(string)
      })),
      {}
    )

    #####################################################
    # EXECUTION
    #####################################################

    automatic = optional(
      bool,
      false
    )

    #####################################################
    # RETRY CONFIGURATION
    #####################################################

    maximum_automatic_attempts = optional( number,5)

    retry_attempt_seconds = optional( number, 60 )

    #####################################################
    # ENABLE / DISABLE
    #####################################################

    enabled = optional(bool,true)

  }))

  default = {}

}
