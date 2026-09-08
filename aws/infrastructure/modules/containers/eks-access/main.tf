#########################################################
# ACCESS ENTRY
#########################################################

resource "aws_eks_access_entry" "this" {

  for_each = var.access_entries

  cluster_name = var.cluster_names[
    each.value.cluster
  ]

  principal_arn = each.value.principal_arn

  kubernetes_groups = each.value.kubernetes_groups

  type = each.value.type

}

#########################################################
# ACCESS POLICY ASSOCIATION
#########################################################

locals {

  policy_map = merge([

    for entry_name, entry in var.access_entries : {

      for policy_name, policy in entry.policy_associations :

      "${entry_name}-${policy_name}" => {

        entry = entry_name

        cluster = entry.cluster

        principal_arn = entry.principal_arn

        policy_arn = policy.policy_arn

        access_scope = policy.access_scope

      }

    }

  ]...)

}

resource "aws_eks_access_policy_association" "this" {

  for_each = local.policy_map

  cluster_name = var.cluster_names[
    each.value.cluster
  ]

  principal_arn = each.value.principal_arn

  policy_arn = each.value.policy_arn

  access_scope {

    type = each.value.access_scope.type

    namespaces = try(
      each.value.access_scope.namespaces,
      null
    )

  }

}
