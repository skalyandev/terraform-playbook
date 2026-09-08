############################################################
# TRUST POLICY DOCUMENT
############################################################

data "aws_iam_policy_document" "trust" {

  for_each = var.roles

  # AWS Services
  dynamic "statement" {

    for_each = length(each.value.trusted_services) > 0 ? [1] : []

    content {

      sid = "AWSServiceTrust"
      effect = "Allow"
      actions = [
        "sts:AssumeRole"
      ]

      principals {

        type = "Service"
        identifiers = [
          for service in each.value.trusted_services :
          "${service}.amazonaws.com"
        ]
      }
    }
  }

  #
  # AWS Accounts / IAM Roles
  #
  dynamic "statement" {

    for_each = length(each.value.trusted_aws_arns) > 0 ? [1] : []

    content {
      sid = "AWSTrust"
      effect = "Allow"
      actions = [
        "sts:AssumeRole"
      ]
      principals {
        type = "AWS"
        identifiers = each.value.trusted_aws_arns
      }
    }
  }
}

############################################################
# IAM ROLE
############################################################

resource "aws_iam_role" "this" {

  for_each = var.roles

  name = each.key
  description = each.value.description
  assume_role_policy = data.aws_iam_policy_document.trust[each.key].json
  max_session_duration = each.value.max_session_duration
  path = each.value.path
  tags = merge(

    var.tags,
    each.value.tags,
    {
      Name = each.key
    }
  )

}
