#########################################################
# IAM POLICY
#########################################################

resource "aws_iam_policy" "this" {

  name        = "${var.cluster_name}-aws-load-balancer-controller"
  description = "AWS Load Balancer Controller Policy"

  policy = file("${path.module}/iam-policy.json")

  tags = var.tags

}

#########################################################
# IAM TRUST POLICY
#########################################################

data "aws_iam_policy_document" "assume_role" {

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

      variable = "${replace(var.oidc_provider_url, "https://", "")}:sub"

      values = [
        "system:serviceaccount:kube-system:aws-load-balancer-controller"
      ]

    }

    condition {

      test = "StringEquals"

      variable = "${replace(var.oidc_provider_url, "https://", "")}:aud"

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

  name = "${var.cluster_name}-aws-load-balancer-controller"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = var.tags

}

#########################################################
# POLICY ATTACHMENT
#########################################################

resource "aws_iam_role_policy_attachment" "this" {

  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn

}
