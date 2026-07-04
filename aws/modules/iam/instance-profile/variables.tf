variable "instance_profiles" {

  description = "IAM Instance Profiles"

  type = map(object({

    role = string
    path = optional(string, "/")
    tags = optional(map(string), {})

  }))

}

variable "role_names" {

  description = "IAM Role Names"
  type = map(string)

}

variable "tags" {

  description = "Common Tags"
  type = map(string)
  default = {}

}
