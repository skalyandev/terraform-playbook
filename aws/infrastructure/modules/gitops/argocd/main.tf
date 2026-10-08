resource "helm_release" "this" {
  count = var.argocd.enabled ? 1 : 0

  name       = var.argocd.release_name
  namespace  = var.argocd.namespace

  repository = var.argocd.repository
  chart      = var.argocd.chart_name
  version    = var.argocd.chart_version

  create_namespace = true

  wait            = true
  wait_for_jobs   = true
  atomic          = true
  cleanup_on_fail = true

  timeout = 900

  values = [
    yamlencode({
      server = {
        replicas = var.argocd.server_replicas

        service = {
          type = var.argocd.server_service_type

          servicePortHttp = var.argocd.server_service_port
          servicePortHttps = 443
        }

        resources = {
          requests = {
            cpu    = var.argocd.resources.server.cpu_request
            memory = var.argocd.resources.server.memory_request
          }

          limits = {
            cpu    = var.argocd.resources.server.cpu_limit
            memory = var.argocd.resources.server.memory_limit
          }
        }

        extraArgs = var.argocd.server_insecure ? [
          "--insecure"
        ] : []
      }

      repoServer = {
        replicas = var.argocd.repo_server_replicas

        resources = {
          requests = {
            cpu    = var.argocd.resources.repo_server.cpu_request
            memory = var.argocd.resources.repo_server.memory_request
          }

          limits = {
            cpu    = var.argocd.resources.repo_server.cpu_limit
            memory = var.argocd.resources.repo_server.memory_limit
          }
        }
      }

      controller = {
        replicas = var.argocd.controller_replicas

        resources = {
          requests = {
            cpu    = var.argocd.resources.controller.cpu_request
            memory = var.argocd.resources.controller.memory_request
          }

          limits = {
            cpu    = var.argocd.resources.controller.cpu_limit
            memory = var.argocd.resources.controller.memory_limit
          }
        }
      }

      redis-ha = {
        enabled = var.argocd.redis_ha_enabled
      }

      applicationSet = {
        enabled = var.argocd.application_set_enabled
      }

      notifications = {
        enabled = var.argocd.notifications_enabled
      }
    })
  ]
}
