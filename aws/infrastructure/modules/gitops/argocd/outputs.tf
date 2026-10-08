output "release_name" {
  description = "Argo CD Helm release name."

  value = var.argocd.enabled ? (
    helm_release.this[0].name
  ) : null
}

output "namespace" {
  description = "Argo CD namespace."

  value = var.argocd.enabled ? (
    helm_release.this[0].namespace
  ) : null
}

output "release_status" {
  description = "Argo CD Helm release status."

  value = var.argocd.enabled ? (
    helm_release.this[0].status
  ) : null
}

output "server_service_name" {
  description = "Argo CD server service name."

  value = var.argocd.enabled ? (
    "${var.argocd.release_name}-server"
  ) : null
}

output "server_service_port" {
  description = "Argo CD server service port."

  value = var.argocd.enabled ? (
    var.argocd.server_service_port
  ) : null
}
