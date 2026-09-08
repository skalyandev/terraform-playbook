output "addon_names" {
  description = "EKS managed add-on names"

  value = {
    for key, addon in aws_eks_addon.this :
    key => addon.addon_name
  }
}

output "addon_versions" {
  description = "EKS managed add-on versions"

  value = {
    for key, addon in aws_eks_addon.this :
    key => addon.addon_version
  }
}

output "addon_arns" {
  description = "EKS managed add-on ARNs"

  value = {
    for key, addon in aws_eks_addon.this :
    key => addon.arn
  }
}
