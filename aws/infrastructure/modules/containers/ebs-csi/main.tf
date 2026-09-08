#########################################################
# EBS CSI DRIVER
#########################################################

resource "aws_eks_addon" "this" {

  cluster_name = var.cluster_names[
    var.ebs_csi.cluster
  ]

  addon_name = "aws-ebs-csi-driver"

  addon_version = var.ebs_csi.addon_version

  service_account_role_arn = aws_iam_role.this.arn

  resolve_conflicts_on_create = var.ebs_csi.resolve_conflicts_on_create

  resolve_conflicts_on_update = var.ebs_csi.resolve_conflicts_on_update

  tags = merge(

    var.tags,

    {
      Name = "aws-ebs-csi-driver"
    }

  )

}
