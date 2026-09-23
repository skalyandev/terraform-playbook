variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

#KMS KEY
variable "kms_key_arn" {
  type    = string
  default = null
}

