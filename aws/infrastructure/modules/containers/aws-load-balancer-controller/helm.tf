#########################################################
# AWS LOAD BALANCER CONTROLLER HELM RELEASE
#########################################################

resource "helm_release" "aws_load_balancer_controller" {

  name = "aws-load-balancer-controller"

  namespace = "kube-system"

  repository = "https://aws.github.io/eks-charts"

  chart = "aws-load-balancer-controller"

  version = var.chart_version


  #######################################################
  # Controller configuration
  #######################################################

  set = [

    {
      name  = "clusterName"
      value = var.cluster_name
    },

    {
      name  = "region"
      value = var.region
    },

    {
      name  = "vpcId"
      value = var.vpc_id
    },


    ###################################################
    # IRSA Service Account
    ###################################################

    {
      name  = "serviceAccount.create"
      value = "false"
    },

    {
      name  = "serviceAccount.name"
      value = var.service_account_name
    },


    ###################################################
    # HA Controller
    ###################################################

    {
      name  = "replicaCount"
      value = "2"
    }

  ]


  depends_on = [

    kubernetes_service_account.this

  ]

}
