output "file_system_id" {
  description = "EFS filesystem ID."

  value = var.efs.enabled ? (
    aws_efs_file_system.this[0].id
  ) : null
}

output "file_system_arn" {
  description = "EFS filesystem ARN."

  value = var.efs.enabled ? (
    aws_efs_file_system.this[0].arn
  ) : null
}

output "security_group_ids" {
  description = "Security group IDs used by EFS mount targets."

  value = var.efs.enabled ? var.security_group_ids : []
}

output "mount_target_ids" {
  description = "EFS mount target IDs."

  value = {
    for subnet_id, mount_target in aws_efs_mount_target.this :
    subnet_id => mount_target.id
  }
}

output "mount_target_dns_names" {
  description = "EFS mount target DNS names."

  value = {
    for subnet_id, mount_target in aws_efs_mount_target.this :
    subnet_id => mount_target.dns_name
  }
}
