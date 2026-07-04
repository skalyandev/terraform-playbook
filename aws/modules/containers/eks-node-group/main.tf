#########################################################
# EKS NODE GROUPS
#########################################################

resource "aws_eks_node_group" "this" {

  for_each = var.eks_node_groups

  #######################################################
  # BASIC
  #######################################################

  cluster_name = var.cluster_names[
    each.value.cluster
  ]

  node_group_name = each.key

  node_role_arn = var.role_arns[
    each.value.role
  ]

  #######################################################
  # NETWORK
  #######################################################

  subnet_ids = values(var.private_subnet_ids)
  

  #######################################################
  # SCALING
  #######################################################

  scaling_config {

    desired_size = each.value.scaling.desired
    min_size = each.value.scaling.minimum
    max_size = each.value.scaling.maximum

  }

  #######################################################
  # COMPUTE
  #######################################################

  instance_types = each.value.instance_types
  capacity_type = each.value.capacity_type
  ami_type = each.value.ami_type
  disk_size = each.value.disk_size

  #######################################################
  # LABELS
  #######################################################

  labels = lookup(
    each.value,
    "labels",
    {}
  )

  #######################################################
  # TAGS
  #######################################################

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
