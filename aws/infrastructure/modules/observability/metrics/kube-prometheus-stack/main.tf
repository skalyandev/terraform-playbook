#########################################################
# KUBE PROMETHEUS STACK
#########################################################

resource "helm_release" "this" {
  count = var.kube_prometheus_stack.enabled ? 1 : 0

  #######################################################
  # HELM RELEASE
  #######################################################

  name       = var.kube_prometheus_stack.release_name
  repository = var.kube_prometheus_stack.repository
  chart      = var.kube_prometheus_stack.chart_name
  version    = var.kube_prometheus_stack.chart_version

  namespace        = var.kube_prometheus_stack.namespace
  create_namespace = true

  #######################################################
  # RELEASE BEHAVIOR
  #######################################################

  wait            = true
  wait_for_jobs   = true
  atomic          = true
  cleanup_on_fail = true

  timeout = 900

  #######################################################
  # HELM VALUES
  #######################################################

  values = [
    yamlencode({

      ###################################################
      # DEFAULT RULES
      ###################################################

      defaultRules = {
        create = true
      }

      ###################################################
      # PROMETHEUS OPERATOR
      ###################################################

      prometheusOperator = {
        enabled = true
      }

      ###################################################
      # PROMETHEUS
      ###################################################

      prometheus = {
        enabled = var.kube_prometheus_stack.prometheus_enabled

        prometheusSpec = {

          #################################################
          # RETENTION
          #################################################

          retention = var.kube_prometheus_stack.prometheus_retention

          #################################################
          # RESOURCES
          #################################################

          resources = {
            requests = {
              cpu    = var.kube_prometheus_stack.prometheus_cpu_request
              memory = var.kube_prometheus_stack.prometheus_memory_request
            }

            limits = {
              cpu    = var.kube_prometheus_stack.prometheus_cpu_limit
              memory = var.kube_prometheus_stack.prometheus_memory_limit
            }
          }

          #################################################
          # PERSISTENT STORAGE
          #################################################

          storageSpec = {
            volumeClaimTemplate = {
              spec = {

                storageClassName = var.kube_prometheus_stack.prometheus_storage_class

                accessModes = [
                  "ReadWriteOnce"
                ]

                resources = {
                  requests = {
                    storage = var.kube_prometheus_stack.prometheus_storage_size
                  }
                }
              }
            }
          }
        }
      }

      ###################################################
      # GRAFANA
      ###################################################

      grafana = {
        enabled = var.kube_prometheus_stack.grafana_enabled

        #################################################
        # SERVICE
        #################################################

        service = {
          type = "ClusterIP"
        }

        #################################################
        # PERSISTENCE
        #################################################

        persistence = {
          enabled = true

          type = "pvc"

          storageClassName = var.kube_prometheus_stack.grafana_storage_class

          accessModes = [
            "ReadWriteOnce"
          ]

          size = var.kube_prometheus_stack.grafana_storage_size
        }

        #################################################
        # RESOURCES
        #################################################

        resources = {
          requests = {
            cpu    = var.kube_prometheus_stack.grafana_cpu_request
            memory = var.kube_prometheus_stack.grafana_memory_request
          }

          limits = {
            cpu    = var.kube_prometheus_stack.grafana_cpu_limit
            memory = var.kube_prometheus_stack.grafana_memory_limit
          }
        }

        #################################################
        # DEFAULT DASHBOARDS
        #################################################

        defaultDashboardsEnabled = true

        #################################################
        # SIDE CAR
        #################################################

        sidecar = {
          dashboards = {
            enabled = true
          }

          datasources = {
            enabled = true
          }
        }
      }

      ###################################################
      # ALERTMANAGER
      ###################################################

      alertmanager = {
        enabled = var.kube_prometheus_stack.alertmanager_enabled

        alertmanagerSpec = {

          storage = {
            volumeClaimTemplate = {
              spec = {

                storageClassName = var.kube_prometheus_stack.alertmanager_storage_class

                accessModes = [
                  "ReadWriteOnce"
                ]

                resources = {
                  requests = {
                    storage = var.kube_prometheus_stack.alertmanager_storage_size
                  }
                }
              }
            }
          }
        }
      }

      ###################################################
      # KUBE STATE METRICS
      ###################################################

      kubeStateMetrics = {
        enabled = var.kube_prometheus_stack.kube_state_metrics_enabled

        resources = {
          requests = {
            cpu    = var.kube_prometheus_stack.kube_state_metrics_cpu_request
            memory = var.kube_prometheus_stack.kube_state_metrics_memory_request
          }
        }
      }

      ###################################################
      # NODE EXPORTER
      ###################################################

      nodeExporter = {
        enabled = var.kube_prometheus_stack.node_exporter_enabled

        resources = {
          requests = {
            cpu    = var.kube_prometheus_stack.node_exporter_cpu_request
            memory = var.kube_prometheus_stack.node_exporter_memory_request
          }
        }
      }
    })
  ]
}
