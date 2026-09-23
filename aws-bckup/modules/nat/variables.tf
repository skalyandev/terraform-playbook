variable "name" {

  description = "Name prefix for NAT resources"

  type = string
}

variable "enable_nat_gateway" {

  description = "Enable or disable NAT Gateway creation"

  type = bool

  default = true
}

variable "public_subnet_ids" {

  description = "List of public subnet IDs where NAT Gateway can be created"

  type = list(string)
}

variable "tags" {

  description = "Common tags"

  type = map(string)

  default = {}
}
