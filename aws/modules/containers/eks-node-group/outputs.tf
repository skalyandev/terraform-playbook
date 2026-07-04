#########################################################
# NODE GROUP IDS
#########################################################

output "node_group_ids" {

  value = {

    for k, v in aws_eks_node_group.this :

    k => v.id

  }

}

#########################################################
# NODE GROUP ARNS
#########################################################

output "node_group_arns" {

  value = {

    for k, v in aws_eks_node_group.this :

    k => v.arn

  }

}

#########################################################
# NODE GROUP STATUS
#########################################################

output "node_group_status" {

  value = {

    for k, v in aws_eks_node_group.this :

    k => v.status

  }

}

#########################################################
# COMPLETE OBJECTS
#########################################################

output "node_groups" {

  value = aws_eks_node_group.this

}
