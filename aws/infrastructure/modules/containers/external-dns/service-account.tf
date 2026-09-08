#########################################################
# EXTERNAL DNS SERVICE ACCOUNT
#########################################################

resource "kubernetes_service_account_v1" "external_dns" {

  metadata {
    name = "external-dns"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.external_dns.arn
    }

    labels = {
      "app.kubernetes.io/name" = "external-dns"
      "app.kubernetes.io/managed-by" = "terraform"
    }

  }

}
