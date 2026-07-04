variable "attachments" {

  description = "Role Policy Attachments"

  type = map(object({
    role = string
    custom_policies = optional(list(string), [])
    managed_policies = optional(list(string), [])
  }))

}

variable "role_names" {

  description = "IAM Role Names"
  type = map(string)

}

variable "policy_arns" {

  description = "Custom Policy ARNs"
  type = map(string)
  default = {}

}
