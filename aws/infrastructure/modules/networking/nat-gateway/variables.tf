variable "nat_gateways" {

  description = "NAT Gateway Definitions"

  type = map(object({
    allocation_id = string
    subnet_id     = string
  }))
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)
  default     = {}
}
