variable "cluster_names" {
  type = map(string)
}

variable "access_entries" {

  type = map(object({

    cluster = string
    principal_arn = string
    kubernetes_groups = optional(list(string), [])
    type = optional(string, "STANDARD")
    policy_associations = optional(map(object({
      policy_arn = string
      access_scope = object({
        type = string
        namespaces = optional(list(string))
      })

    })), {})

  }))

}
