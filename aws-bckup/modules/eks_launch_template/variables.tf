variable "name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "volume_size" {
  type = number
}

variable "security_group_ids" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}
