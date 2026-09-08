#########################################################
# AWS LOAD BALANCER CONTROLLER SERVICE ACCOUNT
#########################################################

resource "kubernetes_service_account" "this" {

  metadata {

    name = var.service_account_name

    namespace = "kube-system"


    annotations = {

      "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn

    }


    labels = {

      "app.kubernetes.io/name" = "aws-load-balancer-controller"

      "app.kubernetes.io/managed-by" = "terraform"

    }

  }

}
