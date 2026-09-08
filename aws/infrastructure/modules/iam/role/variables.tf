variable "roles" {

  description = "IAM Roles"

  type = map(object({

    description          = optional(string)
    trusted_services     = optional(list(string), [])
    trusted_aws_arns     = optional(list(string), [])
    max_session_duration = optional(number, 3600)
    path                 = optional(string, "/")
    tags                 = optional(map(string), {})

  }))

}

variable "tags" {

  type = map(string)

  default = {}

}
