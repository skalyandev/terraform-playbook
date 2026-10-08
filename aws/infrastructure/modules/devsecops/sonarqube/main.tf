resource "helm_release" "this" {
  count = var.sonarqube.enabled ? 1 : 0

  name       = var.sonarqube.release_name
  namespace  = var.sonarqube.namespace

  repository = var.sonarqube.repository
  chart      = var.sonarqube.chart_name
  version    = var.sonarqube.chart_version

  create_namespace = true

  wait            = true
  wait_for_jobs   = true
  atomic          = true
  cleanup_on_fail = true

  timeout = 900

  values = [
    yamlencode({
      replicaCount = var.sonarqube.replicas
    
      community = {
        enabled = var.sonarqube.community_enabled
      }

      monitoringPasscode = var.sonarqube.monitoring_passcode
      
      service = {
        type = var.sonarqube.service_type

        ports = {
          http = var.sonarqube.service_port
        }
      }

      persistence = {
        enabled = var.sonarqube.persistence_enabled

        storageClass = var.sonarqube.persistence_storage_class
        size         = var.sonarqube.persistence_size

        accessMode = "ReadWriteOnce"
      }

      resources = {
        requests = {
          cpu    = var.sonarqube.cpu_request
          memory = var.sonarqube.memory_request
        }

        limits = {
          cpu    = var.sonarqube.cpu_limit
          memory = var.sonarqube.memory_limit
        }
      }

      ingress = {
        enabled = false
      }
    })
  ]
}
