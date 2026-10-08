#########################################################
# HELM RELEASE
#########################################################

output "release_name" {
  description = "Kube Prometheus Stack Helm release name"

  value = var.kube_prometheus_stack.enabled ? (
    helm_release.this[0].name
  ) : null
}

output "namespace" {
  description = "Kubernetes namespace where Kube Prometheus Stack is installed"

  value = var.kube_prometheus_stack.enabled ? (
    helm_release.this[0].namespace
  ) : null
}

output "release_status" {
  description = "Kube Prometheus Stack Helm release status"

  value = var.kube_prometheus_stack.enabled ? (
    helm_release.this[0].status
  ) : null
}

#########################################################
# SERVICES
#########################################################

output "grafana_service_name" {
  description = "Grafana Kubernetes service name"

  value = var.kube_prometheus_stack.enabled ? (
    "${var.kube_prometheus_stack.release_name}-grafana"
  ) : null
}

output "prometheus_service_name" {
  description = "Prometheus Kubernetes service name"

  value = var.kube_prometheus_stack.enabled ? (
    "${var.kube_prometheus_stack.release_name}-prometheus"
  ) : null
}

output "alertmanager_service_name" {
  description = "Alertmanager Kubernetes service name"

  value = var.kube_prometheus_stack.enabled ? (
    "${var.kube_prometheus_stack.release_name}-alertmanager"
  ) : null
}
