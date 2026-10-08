output "release_name" {
  description = "Trivy Operator Helm release name."

  value = var.trivy_operator.enabled ? (
    helm_release.this[0].name
  ) : null
}

output "namespace" {
  description = "Trivy Operator namespace."

  value = var.trivy_operator.enabled ? (
    helm_release.this[0].namespace
  ) : null
}

output "release_status" {
  description = "Trivy Operator Helm release status."

  value = var.trivy_operator.enabled ? (
    helm_release.this[0].status
  ) : null
}
