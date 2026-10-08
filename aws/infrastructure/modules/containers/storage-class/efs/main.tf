resource "kubernetes_storage_class_v1" "this" {
  count = var.efs_storage_class.enabled ? 1 : 0

  metadata {
    name = var.efs_storage_class.name

    annotations = var.efs_storage_class.annotations
    labels      = var.efs_storage_class.labels
  }

  storage_provisioner = "efs.csi.aws.com"

  reclaim_policy      = var.efs_storage_class.reclaim_policy
  volume_binding_mode = var.efs_storage_class.volume_binding_mode

  mount_options = var.efs_storage_class.mount_options

  parameters = {
    provisioningMode = var.efs_storage_class.provisioning_mode
    fileSystemId     = var.efs_storage_class.file_system_id
    directoryPerms   = var.efs_storage_class.directory_perms
    basePath         = var.efs_storage_class.base_path
  }
}
