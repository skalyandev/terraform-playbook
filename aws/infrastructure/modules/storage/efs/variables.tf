variable "efs" {
  description = "AWS EFS filesystem configuration."

  type = object({
    enabled                              = bool
    name                                 = string
    encrypted                            = bool
    performance_mode                     = string
    throughput_mode                      = string
    transition_to_ia                     = string
    transition_to_archive                = string
    transition_to_primary_storage_class = string

    tags = optional(map(string), {})
  })
}

variable "subnet_ids" {
  description = "Subnet IDs where EFS mount targets are created."

  type = map(string)
}

variable "security_group_ids" {
  description = "Security group IDs attached to EFS mount targets."

  type = list(string)
}
