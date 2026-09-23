output "addon_name" {
  value = aws_eks_addon.ebs_csi.addon_name
}

output "addon_version" {
  value = aws_eks_addon.ebs_csi.addon_version
}
