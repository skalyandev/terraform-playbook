variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "enable_nat_gateway" {
  type = bool
  default = false
}

#variable "public_subnet_ids" {
#  type = list(string)
#  default = []
#}

variable "internet_gateway_id" {
  type = string
}

variable "nat_gateway_id" {
  type = string
}

variable "tags" {
  type = map(string) 
}
