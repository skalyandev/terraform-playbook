#########################################################
# CLUSTER AUTOSCALER IAM POLICY
#########################################################

resource "aws_iam_policy" "this" {

  name = local.role_name

  description = "Permissions required by Kubernetes Cluster Autoscaler"

  policy = file(var.iam_policy_path)

  tags = var.tags

}


#########################################################
# CLUSTER AUTOSCALER IAM ROLE
#########################################################

resource "aws_iam_role" "this" {

  name = local.role_name

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Federated = var.oidc_provider_arn

        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {

          StringEquals = {

            "${replace(var.oidc_provider_url, "https://", "")}:aud" = "sts.amazonaws.com"

            "${replace(var.oidc_provider_url, "https://", "")}:sub" = "system:serviceaccount:${var.cluster_autoscaler.namespace}:${var.cluster_autoscaler.service_account_name}"

          }

        }

      }

    ]

  })

  tags = var.tags

}


#########################################################
# ATTACH CLUSTER AUTOSCALER POLICY
#########################################################

resource "aws_iam_role_policy_attachment" "this" {

  role = aws_iam_role.this.name

  policy_arn = aws_iam_policy.this.arn

}
