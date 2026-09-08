############################################################
# CUSTOM IAM POLICIES
############################################################

resource "aws_iam_policy" "this" {

  for_each = var.policies

  name = each.key
  description = each.value.description
  policy = file(each.value.policy_file)
  path = each.value.path
  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name = each.key
    }
  )
}
