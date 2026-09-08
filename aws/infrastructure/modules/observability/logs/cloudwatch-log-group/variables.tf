#########################################################
# CLOUDWATCH LOG GROUPS
#########################################################

variable "cloudwatch_log_groups" {

  description = "CloudWatch Log Group configurations"

  type = map(object({

    name              = string
    retention_in_days = optional(number, 30)
    kms_key_id        = optional(string)
    log_group_class   = optional(string, "STANDARD")
    skip_destroy      = optional(bool, false)

    tags = optional(map(string), {})

  }))

  validation {

    condition = alltrue([
      for lg in values(var.cloudwatch_log_groups) :
      contains(
        ["STANDARD", "INFREQUENT_ACCESS"],
        lg.log_group_class
      )
    ])

    error_message = "log_group_class must be STANDARD or INFREQUENT_ACCESS."

  }

}

#########################################################
# COMMON TAGS
#########################################################

variable "tags" {

  description = "Common tags applied to all Log Groups"

  type = map(string)

  default = {}

}
