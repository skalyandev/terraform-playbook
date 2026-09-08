resource "aws_eks_addon" "this" {
  cluster_name = var.cluster_names[var.efs_csi.cluster]

  addon_name   = "aws-efs-csi-driver"
  addon_version = var.efs_csi.addon_version

  service_account_role_arn = aws_iam_role.this.arn

  resolve_conflicts_on_create = var.efs_csi.resolve_conflicts_on_create
  resolve_conflicts_on_update = var.efs_csi.resolve_conflicts_on_update

  tags = merge(
    var.tags,
    {
      Name = "aws-efs-csi-driver"
    }
  )
}
