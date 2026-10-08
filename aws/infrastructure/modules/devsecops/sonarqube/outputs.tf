output "release_name" {
  description = "SonarQube Helm release name."

  value = var.sonarqube.enabled ? (
    helm_release.this[0].name
  ) : null
}

output "namespace" {
  description = "SonarQube Kubernetes namespace."

  value = var.sonarqube.enabled ? (
    helm_release.this[0].namespace
  ) : null
}

output "release_status" {
  description = "SonarQube Helm release status."

  value = var.sonarqube.enabled ? (
    helm_release.this[0].status
  ) : null
}

output "service_name" {
  description = "SonarQube Kubernetes Service name."

  value = var.sonarqube.enabled ? (
    "${var.sonarqube.release_name}-sonarqube"
  ) : null
}

output "service_port" {
  description = "SonarQube Kubernetes Service port."

  value = var.sonarqube.enabled ? (
    var.sonarqube.service_port
  ) : null
}
