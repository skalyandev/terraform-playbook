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


