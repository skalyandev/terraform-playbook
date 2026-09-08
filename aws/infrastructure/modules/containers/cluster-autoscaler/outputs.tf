#########################################################
# IAM ROLE ARN
#########################################################

output "eks_autoscaler_iam_role_arn" {

  description = "IAM role ARN used by Cluster Autoscaler"
  value = aws_iam_role.this.arn

}


#########################################################
# IAM ROLE NAME
#########################################################

output "eks_autoscaler_iam_role_name" {

  description = "IAM role name used by Cluster Autoscaler"
  value = aws_iam_role.this.name

}


#########################################################
# IAM POLICY ARN
#########################################################

output "eks_autoscaler_iam_policy_arn" {

  description = "IAM policy ARN used by Cluster Autoscaler"
  value = aws_iam_policy.this.arn

}


#########################################################
# SERVICE ACCOUNT
#########################################################

output "eks_autoscaler_service_account_name" {

  description = "Kubernetes ServiceAccount used by Cluster Autoscaler"
  value = kubernetes_service_account.this.metadata[0].name

}


#########################################################
# HELM RELEASE
#########################################################
output "eks_autoscaler_helm_release_name" {

  description = "Cluster Autoscaler Helm release name"
  value = helm_release.this.name

}


#########################################################
# HELM RELEASE_STATUS
#########################################################

output "eks_autoscaler_helm_release_status" {

  description = "Cluster Autoscaler Helm release status"
  value = helm_release.this.status

}
