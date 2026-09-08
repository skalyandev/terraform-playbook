#########################################################
# CLUSTER IDS
#########################################################

output "cluster_ids" {

  value = {

    for k, v in aws_eks_cluster.this :

    k => v.id

  }

}

#########################################################
# CLUSTER ARNS
#########################################################

output "cluster_arns" {

  value = {

    for k, v in aws_eks_cluster.this :

    k => v.arn

  }

}

#########################################################
# CLUSTER ENDPOINTS
#########################################################

output "cluster_endpoints" {

  value = {

    for k, v in aws_eks_cluster.this :

    k => v.endpoint

  }

}

#########################################################
# CERTIFICATE AUTHORITY
#########################################################

output "cluster_certificate_authorities" {

  value = {

    for k, v in aws_eks_cluster.this :

    k => v.certificate_authority[0].data

  }

}

#########################################################
# CLUSTER VERSIONS
#########################################################

output "cluster_versions" {

  value = {

    for k, v in aws_eks_cluster.this :

    k => v.version

  }

}

#########################################################
# CLUSTER NAMES
#########################################################

output "cluster_names" {

  value = {
    for k, v in aws_eks_cluster.this :
    k => v.name
  }

}

#########################################################
# OIDC ISSUER URLS
#########################################################

output "cluster_oidc_issuers" {

  description = "OIDC issuer URLs"

  value = {
    for k, v in aws_eks_cluster.this :
    k => v.identity[0].oidc[0].issuer
  }

}

#########################################################
# OIDC PROVIDER ARNS
#########################################################

output "cluster_oidc_provider_arns" {

  description = "OIDC Provider ARN"

  value = {

    for k, v in aws_iam_openid_connect_provider.this :

    k => v.arn

  }

}


