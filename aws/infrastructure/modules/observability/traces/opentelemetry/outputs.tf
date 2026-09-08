#########################################################
# OPENTELEMETRY NAMESPACE
#########################################################

output "opentelemetry_namespace" {

  description = "Kubernetes namespace where OpenTelemetry Collector is deployed."

  value = try(
    kubernetes_namespace.this[0].metadata[0].name,
    null
  )

}


#########################################################
# SERVICE ACCOUNT
#########################################################

output "opentelemetry_service_account_name" {

  description = "Kubernetes ServiceAccount used by OpenTelemetry Collector."

  value = try(
    kubernetes_service_account.this[0].metadata[0].name,
    null
  )

}


#########################################################
# CONFIG MAP
#########################################################

output "opentelemetry_config_map_name" {

  description = "OpenTelemetry Collector configuration ConfigMap."

  value = try(
    kubernetes_config_map.this[0].metadata[0].name,
    null
  )

}


#########################################################
# DEPLOYMENT
#########################################################

output "opentelemetry_deployment_name" {

  description = "OpenTelemetry Collector Deployment name."

  value = try(
    kubernetes_deployment_v1.this[0].metadata[0].name,
    null
  )

}


#########################################################
# SERVICE
#########################################################

output "opentelemetry_service_name" {

  description = "OpenTelemetry Collector Kubernetes Service name."

  value = try(
    kubernetes_service_v1.this[0].metadata[0].name,
    null
  )

}


#########################################################
# OTLP GRPC ENDPOINT
#########################################################

output "opentelemetry_otlp_grpc_endpoint" {

  description = "Internal OTLP gRPC endpoint for applications."

  value = var.opentelemetry.enabled ? format(
    "%s.%s.svc.cluster.local:%d",
    "opentelemetry-collector",
    var.opentelemetry.namespace,
    var.opentelemetry.otlp_grpc_port
  ) : null

}


#########################################################
# OTLP HTTP ENDPOINT
#########################################################

output "opentelemetry_otlp_http_endpoint" {

  description = "Internal OTLP HTTP endpoint for applications."

  value = var.opentelemetry.enabled ? format(
    "http://%s.%s.svc.cluster.local:%d",
    "opentelemetry-collector",
    var.opentelemetry.namespace,
    var.opentelemetry.otlp_http_port
  ) : null

}


#########################################################
# HEALTH CHECK ENDPOINT
#########################################################

output "opentelemetry_health_check_endpoint" {

  description = "OpenTelemetry Collector health check endpoint."

  value = var.opentelemetry.enabled ? format(
    "http://%s.%s.svc.cluster.local:%d",
    "opentelemetry-collector",
    var.opentelemetry.namespace,
    var.opentelemetry.health_check_port
  ) : null

}


