variable "role_name" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "oidc_provider_url" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "enable_ebs_csi" {
  type = bool
  default = false
}
