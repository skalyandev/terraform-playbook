variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "subnets" {
  description = "Subnet Definitions"

  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    subnet_type             = string
    route_table             = string
  }))
}

variable "tags" {
  type = map(string)
  default = {}
}
