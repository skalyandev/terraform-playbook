variable "sonarqube" {
  description = "SonarQube Helm deployment configuration."

  type = object({
    enabled = bool

    release_name = string
    namespace    = string

    repository    = string
    chart_name    = string
    chart_version = string

    replicas = number

    service_type = string
    service_port = number

    persistence_enabled        = bool
    persistence_storage_class  = string
    persistence_size           = string

    monitoring_passcode_enabled = bool
    monitoring_passcode         = string

    cpu_request    = string
    memory_request = string
    cpu_limit      = string
    memory_limit   = string

    #ingress_enabled = bool
    community_enabled = bool

    tags = map(string)
  })
}
