#########################################################
# EBS CSI ADDON
#########################################################

output "ebs_csi_addon_name" {

  description = "EBS CSI EKS add-on name"

  value = aws_eks_addon.this.addon_name

}


#########################################################
# EBS CSI ADDON VERSION
#########################################################

output "ebs_csi_addon_version" {

  description = "EBS CSI EKS add-on version"

  value = aws_eks_addon.this.addon_version

}

#########################################################
# IAM ROLE ARN
#########################################################

output "ebs_csi_iam_role_arn" {

  description = "IAM role ARN used by EBS CSI Driver"

  value = aws_iam_role.this.arn

}


#########################################################
# IAM ROLE NAME
#########################################################

output "ebs_csi_iam_role_name" {

  description = "IAM role name used by EBS CSI Driver"

  value = aws_iam_role.this.name

}


#########################################################
# IAM POLICY ARN
#########################################################

output "ebs_csi_iam_policy_arn" {

  description = "IAM policy ARN used by EBS CSI Driver"

  value = aws_iam_policy.this.arn

}
