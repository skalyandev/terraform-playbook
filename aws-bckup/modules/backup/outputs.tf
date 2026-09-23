output "backup_vault_name" {
  value = aws_backup_vault.bastion.name
}

output "backup_plan_name" {
  value = aws_backup_plan.bastion.name
}
