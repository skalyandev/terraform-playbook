output "storage_class_names" {
  description = "Map of StorageClass keys to Kubernetes StorageClass names."

  value = {
    for key, storage_class in kubernetes_storage_class_v1.this :
    key => storage_class.metadata[0].name
  }
}

output "storage_class_provisioners" {
  description = "Map of StorageClass keys to their storage provisioners."

  value = {
    for key, storage_class in kubernetes_storage_class_v1.this :
    key => storage_class.storage_provisioner
  }
}
