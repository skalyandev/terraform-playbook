variable "efs_storage_class" {
  description = "Configuration for the Kubernetes EFS StorageClass."

  type = object({
    enabled = bool

    name = string

    file_system_id = string

    provisioning_mode = string

    directory_perms = string

    base_path = string

    reclaim_policy      = string
    volume_binding_mode = string

    mount_options = list(string)

    annotations = optional(
      map(string),
      {}
    )

    labels = optional(
      map(string),
      {}
    )
  })
}
