resource "helm_release" "this" {
  count = var.trivy_operator.enabled ? 1 : 0

  name       = var.trivy_operator.release_name
  namespace  = var.trivy_operator.namespace
  repository = var.trivy_operator.repository
  chart      = var.trivy_operator.chart_name
  version    = var.trivy_operator.chart_version

  create_namespace = true

  wait            = true
  wait_for_jobs   = true
  atomic          = true
  cleanup_on_fail = true

  timeout = 900

  values = [
    yamlencode({
      operator = {
        targetNamespaces = var.trivy_operator.target_namespaces
        excludeNamespaces = var.trivy_operator.exclude_namespaces

        scanJobTimeout = var.trivy_operator.scan_job_timeout

        scanJobTTL = var.trivy_operator.scan_job_ttl

        concurrentScanJobsLimit = var.trivy_operator.concurrent_scan_jobs_limit

        scannerReportTTL = var.trivy_operator.scanner_report_ttl

        metricsBindAddress = var.trivy_operator.metrics_bind_address
      }

      resources = {
        requests = {
          cpu    = var.trivy_operator.resources.cpu_request
          memory = var.trivy_operator.resources.memory_request
        }

        limits = {
          cpu    = var.trivy_operator.resources.cpu_limit
          memory = var.trivy_operator.resources.memory_limit
        }
      }
    })
  ]
}
