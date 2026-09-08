variable "subnet_details" {
  description = "Subnet details keyed by subnet name"

  type = map(object({
    id                = string
    availability_zone = string
    subnet_type       = string
    route_table       = string
    cidr_block        = string
  }))
}

variable "route_table_ids" {
  description = "Route table IDs keyed by route table name"

  type = map(string)
}

variable "tags" {
  description = "Common Tags"

  type    = map(string)
  default = {}
}
