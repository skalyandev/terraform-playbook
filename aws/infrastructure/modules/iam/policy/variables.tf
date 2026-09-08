variable "policies" {

  description = "Custom IAM Policies"

  type = map(object({

    description = optional(string)
    policy_file = string
    path = optional(string, "/")
    tags = optional(map(string), {})
  }))

}

variable "tags" {

  description = "Common Tags"
  type = map(string)
  default = {}

}
