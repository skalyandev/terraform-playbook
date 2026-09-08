#########################################################
# METRICS SERVER
#########################################################

resource "helm_release" "this" {

  name = local.name

  repository = var.helm.repository

  chart = var.helm.chart

  version = var.helm.chart_version

  namespace = var.pod_autoscaling.namespace

  create_namespace = false

  wait = true

  atomic = true

  timeout = 600

  values = [

    yamlencode({

      replicas = 2

      apiService = {
        create = true
      }

      serviceAccount = {

        create = true

        name = var.pod_autoscaling.service_account_name

      }

      resources = {

        requests = {

          cpu = "100m"

          memory = "200Mi"

        }

        limits = {

          cpu = "500m"

          memory = "500Mi"

        }

      }

      args = [

        "--cert-dir=/tmp",

        "--secure-port=10250",

        "--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname",

        "--kubelet-use-node-status-port",

        "--metric-resolution=15s"

      ]

    })

  ]

}
