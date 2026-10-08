output "name" {
  description = "Name of the EFS Kubernetes StorageClass."

  value = var.efs_storage_class.enabled ? (
    kubernetes_storage_class_v1.this[0].metadata[0].name
  ) : null
}

output "provisioner" {
  description = "EFS StorageClass provisioner."

  value = var.efs_storage_class.enabled ? (
    kubernetes_storage_class_v1.this[0].storage_provisioner
  ) : null
}

output "file_system_id" {
  description = "EFS filesystem ID used by the StorageClass."

  value = var.efs_storage_class.enabled ? (
    var.efs_storage_class.file_system_id
  ) : null
}
