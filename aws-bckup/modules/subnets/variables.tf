variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type    = list(string)
  default = []
}

variable "private_subnets" {
  type    = list(string)
  default = []
}

variable "database_subnets" {
  type    = list(string)
  default = []
}

variable "azs" {
  type = list
}

variable "map_public_ip_on_launch" {
  type = string
}

variable "tags" {
  type = map(string)
}

