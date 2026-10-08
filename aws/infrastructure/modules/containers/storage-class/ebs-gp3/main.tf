resource "kubernetes_storage_class_v1" "this" {
  for_each = {
    for key, storage_class in var.ebs_gp3_storage_classes :
    key => storage_class
    if storage_class.enabled
  }

  metadata {
    name = each.value.name

    annotations = each.value.annotations
    labels      = each.value.labels
  }

  storage_provisioner = each.value.provisioner

  reclaim_policy         = each.value.reclaim_policy
  volume_binding_mode    = each.value.volume_binding_mode
  allow_volume_expansion = each.value.allow_volume_expansion

  parameters = each.value.parameters
}
