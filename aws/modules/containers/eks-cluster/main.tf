#########################################################
# EKS CLUSTERS
#########################################################
resource "aws_eks_cluster" "this" {

  for_each = var.eks_clusters

  # BASIC
  name = each.key
  version = each.value.version
  role_arn = var.role_arns[
    each.value.role
  ]

  #ACCESS CONFIG
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }


  # NETWORK
  vpc_config {

    subnet_ids = values(
      var.private_subnet_ids
    )

    security_group_ids = [
      for sg in each.value.security_groups :
      var.security_group_ids[sg]
    ]

    endpoint_private_access = lookup(
      each.value,
      "endpoint_private_access",
      true
    )

    endpoint_public_access = lookup(
      each.value,
      "endpoint_public_access",
      false
    )

  }

  # LOGGING
  enabled_cluster_log_types = lookup(
    each.value,
    "enabled_cluster_log_types",
    []
  )

  # TAGS
  tags = merge(

    var.tags,
    lookup(
      each.value,
      "tags",
      {}
    ),

    {
      Name = each.key
    }

  )

}
