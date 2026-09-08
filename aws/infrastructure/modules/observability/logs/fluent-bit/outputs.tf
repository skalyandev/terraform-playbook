#########################################################
# FLUENT BIT NAMESPACE
#########################################################

output "fluentbit_namespace" {

  description = "Kubernetes namespace where Fluent Bit is deployed."

  value = try(
    kubernetes_namespace.this[0].metadata[0].name,
    null
  )

}


#########################################################
# FLUENT BIT SERVICE ACCOUNT
#########################################################

output "fluentbit_service_account_name" {

  description = "Kubernetes service account used by Fluent Bit."

  value = try(
    kubernetes_service_account.this[0].metadata[0].name,
    null
  )

}


#########################################################
# FLUENT BIT DAEMONSET
#########################################################

output "fluentbit_daemonset_name" {

  description = "Fluent Bit DaemonSet name."

  value = try(
    kubernetes_daemon_set_v1.this[0].metadata[0].name,
    null
  )

}

#########################################################
# FLUENT BIT CONFIG MAP
#########################################################

output "fluentbit_config_map_name" {

  description = "Fluent Bit configuration ConfigMap name."

  value = try(
    kubernetes_config_map.this[0].metadata[0].name,
    null
  )

}


#########################################################
# CLOUDWATCH LOG GROUP
#########################################################

output "fluentbit_log_group_name" {

  description = "CloudWatch Log Group used by Fluent Bit."

  value = var.fluent_bit.log_group_name

}


#########################################################
# LOG STREAM PREFIX
#########################################################

output "fluentbit_log_stream_prefix" {

  description = "CloudWatch log stream prefix used by Fluent Bit."

  value = var.fluent_bit.log_stream_prefix

}


#########################################################
# IRSA ROLE ARN
#########################################################

output "fluentbit_irsa_role_arn" {

  description = "IAM role ARN associated with the Fluent Bit service account."

  value = var.fluent_bit.irsa_role_arn

}


