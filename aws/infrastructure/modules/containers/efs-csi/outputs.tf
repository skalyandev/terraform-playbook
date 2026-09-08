output "efs_csi_addon_name" {
  description = "EFS CSI EKS add-on name"
  value       = aws_eks_addon.this.addon_name
}

output "efs_csi_addon_version" {
  description = "EFS CSI EKS add-on version"
  value       = aws_eks_addon.this.addon_version
}

output "efs_csi_iam_role_arn" {
  description = "IAM role ARN used by EFS CSI Driver"
  value       = aws_iam_role.this.arn
}

output "efs_csi_iam_role_name" {
  description = "IAM role name used by EFS CSI Driver"
  value       = aws_iam_role.this.name
}

output "efs_csi_iam_policy_arn" {
  description = "IAM policy ARN used by EFS CSI Driver"
  value       = aws_iam_policy.this.arn
}
