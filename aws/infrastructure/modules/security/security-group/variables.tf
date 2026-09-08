variable "vpc_id" {

  description = "VPC ID"

  type = string

}

variable "security_groups" {

  description = "Security Groups"

  type = map(object({

    description = string

  }))

}

variable "tags" {

  type = map(string)

  default = {}

}
