############################################################
# IAM INSTANCE PROFILES
############################################################

resource "aws_iam_instance_profile" "this" {

  for_each = var.instance_profiles

  name = each.key
  role = var.role_names[each.value.role]
  path = each.value.path
  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name = each.key
    }
  )
}
