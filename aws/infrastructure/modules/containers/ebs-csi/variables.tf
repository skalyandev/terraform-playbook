#########################################################
# EBS CSI DRIVER
#########################################################

variable "ebs_csi" {

  description = "AWS EBS CSI Driver configuration"

  type = object({

    enabled = bool

    cluster = string

    addon_version = string

    service_account_role_name = optional(
      string,
      "ebs-csi-controller"
    )

    resolve_conflicts_on_create = optional(
      string,
      "OVERWRITE"
    )

    resolve_conflicts_on_update = optional(
      string,
      "OVERWRITE"
    )

  })

}


#########################################################
# CLUSTER
#########################################################

variable "cluster_names" {

  description = "Map of EKS cluster names"

  type = map(string)

}


#########################################################
# OIDC PROVIDER
#########################################################

variable "oidc_provider_arns" {

  description = "Map of EKS OIDC provider ARNs"

  type = map(string)

}


variable "oidc_provider_urls" {

  description = "Map of EKS OIDC provider URLs"

  type = map(string)

}


#########################################################
# TAGS
#########################################################

variable "tags" {

  description = "Common tags"

  type = map(string)

  default = {}

}
