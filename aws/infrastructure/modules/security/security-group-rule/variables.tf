variable "security_group_ids" {

  description = "Security Group IDs"

  type = map(string)

}

variable "security_group_rules" {

  description = "Security Group Rules"

  type = any

}
