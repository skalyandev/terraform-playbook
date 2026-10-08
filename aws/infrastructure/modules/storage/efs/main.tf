resource "aws_efs_file_system" "this" {
  count = var.efs.enabled ? 1 : 0

  creation_token = var.efs.name

  encrypted        = var.efs.encrypted
  performance_mode = var.efs.performance_mode
  throughput_mode  = var.efs.throughput_mode

  dynamic "lifecycle_policy" {
    for_each = var.efs.transition_to_ia != "" ? [1] : []

    content {
      transition_to_ia = var.efs.transition_to_ia
    }
  }

  dynamic "lifecycle_policy" {
    for_each = var.efs.transition_to_archive != "" ? [1] : []

    content {
      transition_to_archive = var.efs.transition_to_archive
    }
  }

  dynamic "lifecycle_policy" {
    for_each = var.efs.transition_to_primary_storage_class != "" ? [1] : []

    content {
      transition_to_primary_storage_class = var.efs.transition_to_primary_storage_class
    }
  }

  tags = merge(
    var.efs.tags,
    {
      Name = var.efs.name
    }
  )
}

resource "aws_efs_mount_target" "this" {
  for_each = var.efs.enabled ? var.subnet_ids : {}

  file_system_id = aws_efs_file_system.this[0].id
  subnet_id      = each.value

  security_groups = var.security_group_ids
}
