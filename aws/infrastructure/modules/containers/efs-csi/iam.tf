resource "aws_iam_policy" "this" {
  name        = "AmazonEKS_EFS_CSI_Driver"
  description = "IAM policy for AWS EFS CSI Driver"

  policy = file(
    "${path.root}/../../policies/eks-efs-csi.json"
  )

  tags = merge(
    var.tags,
    {
      Name = "AmazonEKS_EFS_CSI_Driver"
    }
  )
}

resource "aws_iam_role" "this" {
  name = var.efs_csi.service_account_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = var.oidc_provider_arns[var.efs_csi.cluster]
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "${replace(
              var.oidc_provider_urls[var.efs_csi.cluster],
              "https://",
              ""
            )}:aud" = "sts.amazonaws.com"

            "${replace(
              var.oidc_provider_urls[var.efs_csi.cluster],
              "https://",
              ""
            )}:sub" = "system:serviceaccount:kube-system:efs-csi-controller-sa"
          }
        }
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = var.efs_csi.service_account_role_name
    }
  )
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
