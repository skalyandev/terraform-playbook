#########################################################
# AWS SECURITY HUB
#########################################################

variable "security_hub" {

  description = "AWS Security Hub configuration."

  type = object({

    #####################################################
    # ENABLE / DISABLE
    #####################################################

    enabled = optional(
      bool,
      true
    )

    #####################################################
    # STANDARDS
    #####################################################

    enable_aws_foundational_security_best_practices = optional(
      bool,
      true
    )

    enable_cis_aws_foundations_benchmark = optional(
      bool,
      false
    )

    enable_pci_dss = optional(
      bool,
      false
    )

    #####################################################
    # CONTROL CONFIGURATION
    #####################################################

    auto_enable_controls = optional(
      bool,
      true
    )

    #####################################################
    # REGIONAL CONFIGURATION
    #####################################################

    auto_enable_org_members = optional(
      bool,
      false
    )

    #####################################################
    # TAGS
    #####################################################

    tags = optional(
      map(string),
      {}
    )

  })

  default = {

    enabled = false

  }

}
