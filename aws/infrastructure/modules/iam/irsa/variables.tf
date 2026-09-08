#########################################################
# IRSA ROLES
#########################################################

variable "irsa_roles" {

  description = "IRSA Roles"

  type = map(object({

    description = optional(string)
    namespace = string
    service_account = string
    custom_policies = optional(list(string), [])
    path = optional(string, "/")
    max_session_duration = optional(number, 3600)
    tags = optional(map(string), {})

  }))

}

#########################################################
# POLICY ARN MAP
#########################################################

variable "policy_arns" {

  description = "Policy ARN Map"
  type = map(string)

}

#########################################################
# OIDC PROVIDER
#########################################################

variable "oidc_provider_arn" {

  description = "OIDC Provider ARN"
  type = string

}

variable "oidc_provider_url" {

  description = "OIDC Provider URL"
  type = string

}

#########################################################
# TAGS
#########################################################

variable "tags" {

  type = map(string)
  default = {}

}
