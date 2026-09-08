#########################################################
# HELM RELEASE NAME
#########################################################

output "pod_autoscaler_helm_release_name" {

  description = "Metrics Server Helm release name"

  value = helm_release.this.name

}


#########################################################
# HELM RELEASE STATUS
#########################################################

output "pod_autoscaler_helm_release_status" {

  description = "Metrics Server Helm release status"

  value = helm_release.this.status

}


#########################################################
# NAMESPACE
#########################################################

output "pod_autoscaler_namespace" {

  description = "Metrics Server namespace"

  value = var.pod_autoscaling.namespace

}


#########################################################
# SERVICE ACCOUNT
#########################################################

output "pod_autoscaler_service_account_name" {

  description = "Metrics Server ServiceAccount name"

  value = var.pod_autoscaling.service_account_name

}
