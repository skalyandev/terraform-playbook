variable "amis" {

  description = "AMI lookup configuration"

  type = map(object({

    owners = list(string)
    most_recent = optional(bool, true)
    filters = list(object({
      name   = string
      values = list(string)
    }))
  }))
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)
  default     = {}
}
