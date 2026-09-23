resource "aws_backup_vault" "bastion" {

  name = "${var.name}-backup-vault"

  tags = var.tags
}


resource "aws_backup_plan" "bastion" {

  name = "${var.name_prefix}-backup-plan"

  rule {

    rule_name = "daily-backup"

    target_vault_name = aws_backup_vault.bastion.name

    schedule = "cron(0 1 * * ? *)"

    lifecycle {

      delete_after = 30
    }
  }
}
