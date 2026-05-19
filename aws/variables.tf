variable "aws_region" {
  type = string
}

variable "aws_access_key_id" {
  type = string
}

variable "aws_secret_access_key" {
  type      = string
  sensitive = true
}

variable "name_prefix" {
  type = string
}

variable "vpc_cidr_range" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "public_subnet_cidr_a" {
  type = string
}

variable "public_subnet_cidr_b" {
  type = string
}

variable "public_subnet_cidr_c" {
  type = string
  default = null
}

variable "private_subnet_cidr_a" {
  type = string
}

variable "private_subnet_cidr_b" {
  type = string
}

variable "private_subnet_cidr_c" {
  type = string
  default = null
}

variable "database_subnet_cidr_a" {
  type = string
}

variable "database_subnet_cidr_b" {
  type = string
}

variable "database_subnet_cidr_c" {
  type = string
  default = null
}

variable "azs" {
  type =list
}

variable "db_create" {
  type = bool

}

variable "enable_nat_gateway" {
  type    = bool
  default = false
}

variable "internet_gateway_id" {
  type = string
  default = null
}

#variable "private_subnet_ids" {
#  type = string
#}


