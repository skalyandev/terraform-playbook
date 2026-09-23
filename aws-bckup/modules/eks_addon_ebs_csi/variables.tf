variable "cluster_name" {
  type = string
}

variable "service_account_role_arn" {
  type = string
}

variable "addon_version" {
  type = string
  default = null
}

variable "eks_addon_ebs_csi" {
  type = bool
  default = false

}
