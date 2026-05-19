variable "public_subnet_ids" {

  type = list(string)
  default = []
}

variable "private_subnet_ids" {

  type = list(string)
  default = []
}

variable "route_table_id" {

  type = string
}

