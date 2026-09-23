resource "aws_eks_node_group" "this" {

  cluster_name = var.cluster_name

  node_group_name = var.nodegroup_name

  node_role_arn = var.node_role_arn

  subnet_ids = var.subnet_ids

  scaling_config {

    desired_size = var.desired_size

    min_size = var.min_size

    max_size = var.max_size
  }

  launch_template {

    id = var.launch_template_id

    version = "$Latest"
  }
}
