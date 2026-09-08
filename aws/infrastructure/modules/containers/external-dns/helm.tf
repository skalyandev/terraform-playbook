#########################################################
# EXTERNAL DNS HELM
#########################################################

resource "helm_release" "external_dns" {


  name = "external-dns"
  namespace = "kube-system"

  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart = "external-dns"
  version = "1.15.0"
  set = [
    {
      name  = "provider"
      value = "aws"
    },

    {
      name  = "aws.region"
      value = var.region
    },
    {
      name  = "domainFilters[0]"
      value = var.domain_name
    },
    {
      name  = "policy"
      value = "sync"
    },
    {
      name  = "registry"
      value = "txt"
    },
    {
      name  = "txtOwnerId"
      value = var.cluster_name
    },
    {
      name  = "serviceAccount.create"
      value = "false"
    },
    {
      name  = "serviceAccount.name"
      value = "external-dns"
    }
  ]


  depends_on = [

    kubernetes_service_account_v1.external_dns

  ]

}
