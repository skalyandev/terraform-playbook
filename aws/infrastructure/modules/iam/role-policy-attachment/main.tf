##########################################################
# CUSTOM IAM POLICIES
##########################################################

resource "aws_iam_role_policy_attachment" "custom" {

  for_each = local.custom_policy_map
  role = var.role_names[each.value.role]
  policy_arn = each.value.policy_arn

}

##########################################################
# AWS MANAGED POLICIES
##########################################################

resource "aws_iam_role_policy_attachment" "managed" {

  for_each = local.managed_policy_map
  role = var.role_names[each.value.role]
  policy_arn = each.value.policy_arn

}
