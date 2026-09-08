variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "route_tables" {

  description = "Route Table Definitions"

  type = map(object({
    route_type        = string
    availability_zone = string
  }))
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)
  default     = {}
}
