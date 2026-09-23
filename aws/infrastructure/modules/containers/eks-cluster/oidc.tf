#########################################################
# EKS OIDC INFORMATION
#########################################################

data "tls_certificate" "eks" {

  for_each = aws_eks_cluster.this

  url = each.value.identity[0].oidc[0].issuer

}
