#########################################################
# IAM POLICY
#########################################################

resource "aws_iam_policy" "external_dns" {


  name = "${var.cluster_name}-external-dns"
  description = "External DNS Route53 Policy"
  policy = file("${path.module}/iam-policy.json")
  tags = var.tags

}



#########################################################
# TRUST POLICY
#########################################################

data "aws_iam_policy_document" "external_dns_assume_role" {


  statement {


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
      variable = "${replace(var.oidc_provider_url,"https://","")}:sub"
      values = [
        "system:serviceaccount:kube-system:external-dns"
      ]
    }

    condition {
      test = "StringEquals"
      variable = "${replace(var.oidc_provider_url,"https://","")}:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }
  }

}



#########################################################
# IAM ROLE
#########################################################

resource "aws_iam_role" "external_dns" {


  name = "${var.cluster_name}-external-dns"
  assume_role_policy = data.aws_iam_policy_document.external_dns_assume_role.json
  tags = var.tags

}



#########################################################
# ATTACH POLICY
#########################################################

resource "aws_iam_role_policy_attachment" "external_dns" {

  role = aws_iam_role.external_dns.name
  policy_arn = aws_iam_policy.external_dns.arn

}
