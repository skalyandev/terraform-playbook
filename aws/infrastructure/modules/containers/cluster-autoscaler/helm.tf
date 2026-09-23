#########################################################
# CLUSTER AUTOSCALER HELM RELEASE
#########################################################

resource "helm_release" "this" {

  name       = local.name
  repository = var.helm.repository
  chart      = var.helm.chart
  version    = var.helm.chart_version
  namespace  = var.cluster_autoscaler.namespace

  create_namespace = false

  wait    = true
  atomic  = true
  timeout = 600

  values = [
    yamlencode({
      autoDiscovery = {
        clusterName = var.cluster_autoscaler.cluster_name
      }

      awsRegion = data.aws_region.current.name

      rbac = {
        create = true

        serviceAccount = {
          create = false
          name   = var.cluster_autoscaler.service_account_name
        }
      }

      cloudProvider = "aws"
    })
  ]

  depends_on = [
    kubernetes_service_account.this,
  ]

}
