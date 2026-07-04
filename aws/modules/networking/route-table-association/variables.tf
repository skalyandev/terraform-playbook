variable "subnet_ids_by_type" {

  description = "Subnet IDs grouped by subnet type"

  type = map(list(string))
}

variable "route_table_ids" {

  description = "Route Table IDs grouped by route table type"

  type = map(string)
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)
  default     = {}
}
