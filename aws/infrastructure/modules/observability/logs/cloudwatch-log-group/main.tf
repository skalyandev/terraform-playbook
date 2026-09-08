#########################################################
# CLOUDWATCH LOG GROUPS
#########################################################

resource "aws_cloudwatch_log_group" "this" {

  for_each = var.cloudwatch_log_groups

  name              = each.value.name
  retention_in_days = each.value.retention_in_days
  kms_key_id        = each.value.kms_key_id
  log_group_class   = each.value.log_group_class
  skip_destroy      = each.value.skip_destroy

  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name = each.value.name
    }
  )
}
