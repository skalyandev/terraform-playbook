variable "eks_addons" {
  description = "Map of AWS managed EKS add-ons"

  type = map(object({
    cluster_name  = string
    addon_name    = string
    addon_version = string

    resolve_conflicts_on_create = optional(
      string,
      "OVERWRITE"
    )

    resolve_conflicts_on_update = optional(
      string,
      "OVERWRITE"
    )

    tags = optional(
      map(string),
      {}
    )
  }))
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
