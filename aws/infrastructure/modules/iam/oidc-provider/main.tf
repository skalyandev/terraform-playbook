#########################################################
# TLS CERTIFICATES
#########################################################

data "tls_certificate" "this" {

  for_each = var.cluster_oidc_issuers
  url = each.value

}

#########################################################
# OIDC PROVIDERS
#########################################################

resource "aws_iam_openid_connect_provider" "this" {

  for_each = var.cluster_oidc_issuers

  url = each.value
  client_id_list = [
    "sts.amazonaws.com"
  ]
  thumbprint_list = [
    data.tls_certificate.this[each.key].certificates[0].sha1_fingerprint
  ]
  tags = var.tags

}
