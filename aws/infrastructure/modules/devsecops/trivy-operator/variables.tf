variable "trivy_operator" {
  description = "Trivy Operator Helm deployment configuration."

  type = object({
    enabled = bool

    release_name = string
    namespace    = string

    repository    = string
    chart_name    = string
    chart_version = string

    target_namespaces = string
    exclude_namespaces = string

    scan_job_timeout = string

    scan_job_ttl = string

    concurrent_scan_jobs_limit = number

    scanner_report_ttl = string

    metrics_bind_address = string

    resources = object({
      cpu_request    = string
      memory_request = string
      cpu_limit      = string
      memory_limit   = string
    })

    tags = map(string)
  })
}
