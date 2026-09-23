output "addon_name" {
  value = aws_eks_addon.kube_proxy.addon_name
}

output "addon_arn" {
  value = aws_eks_addon.kube_proxy.arn
}

output "addon_version" {
  value = aws_eks_addon.kube_proxy.addon_version
}
