variable "argocd" {
  description = "Argo CD Helm deployment configuration."

  type = object({
    enabled = bool

    release_name = string
    namespace    = string

    repository    = string
    chart_name    = string
    chart_version = string

    server_replicas     = number
    repo_server_replicas = number
    controller_replicas  = number

    server_service_type = string
    server_service_port = number

    server_insecure = bool

    redis_ha_enabled = bool

    application_set_enabled = bool

    notifications_enabled = bool

    resources = object({
      server = object({
        cpu_request    = string
        memory_request = string
        cpu_limit      = string
        memory_limit   = string
      })

      repo_server = object({
        cpu_request    = string
        memory_request = string
        cpu_limit      = string
        memory_limit   = string
      })

      controller = object({
        cpu_request    = string
        memory_request = string
        cpu_limit      = string
        memory_limit   = string
      })
    })

    tags = map(string)
  })
}
