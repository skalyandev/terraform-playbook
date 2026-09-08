#########################################################
# IAM TRUST POLICY
#########################################################

data "aws_iam_policy_document" "trust" {

  for_each = var.irsa_roles

  statement {
    sid    = "IRSA"
    effect = "Allow"
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    principals {
      type = "Federated"
      identifiers = [
        var.oidc_provider_arn
      ]

    }

    condition {

      test = "StringEquals"
      variable = "${local.oidc_url}:sub"
      values = [
        "system:serviceaccount:${each.value.namespace}:${each.value.service_account}"
      ]
    }

    condition {

      test = "StringEquals"
      variable = "${local.oidc_url}:aud"
      values = [
        "sts.amazonaws.com"
      ]

    }

  }

}

#########################################################
# IAM ROLE
#########################################################

resource "aws_iam_role" "this" {

  for_each = var.irsa_roles
  name = each.key
  description = each.value.description
  assume_role_policy = data.aws_iam_policy_document.trust[each.key].json
  path = each.value.path
  max_session_duration = each.value.max_session_duration
  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name = each.key
    }
  )

}

#########################################################
# CUSTOM POLICY ATTACHMENTS
#########################################################

resource "aws_iam_role_policy_attachment" "custom" {

  for_each = local.custom_policy_map
  role = aws_iam_role.this[each.value.role].name
  policy_arn = each.value.policy_arn

}
