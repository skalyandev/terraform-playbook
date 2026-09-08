variable "routes" {

  description = "Route Definitions"

  type = map(object({
    route_table = string
    destination = string
    target_type = string
    target_name = optional(string)
  }))
}

variable "route_table_ids" {

  description = "Route Table IDs"
  type = map(string)
}

variable "internet_gateway_id" {

  description = "Internet Gateway ID"
  type = string
}

variable "nat_gateway_ids" {

  description = "NAT Gateway IDs"
  type = map(string)
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)
  default     = {}
}
