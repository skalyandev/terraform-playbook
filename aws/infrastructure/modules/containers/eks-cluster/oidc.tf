#########################################################
# EKS OIDC PROVIDER
#########################################################

data "tls_certificate" "eks" {

  for_each = aws_eks_cluster.this

  url = each.value.identity[0].oidc[0].issuer

}


resource "aws_iam_openid_connect_provider" "this" {

  for_each = aws_eks_cluster.this


  url = each.value.identity[0].oidc[0].issuer


  client_id_list = [

    "sts.amazonaws.com"

  ]


  thumbprint_list = [

    data.tls_certificate.eks[each.key].certificates[0].sha1_fingerprint

  ]


  tags = var.tags

}
