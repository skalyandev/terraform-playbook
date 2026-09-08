#########################################################
# CLUSTER AUTOSCALER SERVICE ACCOUNT
#########################################################

resource "kubernetes_service_account" "this" {

  metadata {

    name = var.cluster_autoscaler.service_account_name

    namespace = var.cluster_autoscaler.namespace

    annotations = {

      "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn

    }

    labels = {

      "app.kubernetes.io/name" = local.name

      "app.kubernetes.io/component" = "cluster-autoscaler"

    }

  }

}
