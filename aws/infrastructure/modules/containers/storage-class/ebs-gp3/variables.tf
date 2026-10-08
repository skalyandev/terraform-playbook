variable "ebs_gp3_storage_classes" {
  description = "Kubernetes EBS GP3 StorageClass configurations."

  type = map(object({
    enabled = bool

    name = string

    provisioner = string

    reclaim_policy         = string
    volume_binding_mode    = string
    allow_volume_expansion = bool

    parameters = map(string)

    annotations = optional(
      map(string),
      {}
    )

    labels = optional(
      map(string),
      {}
    )
  }))
}
