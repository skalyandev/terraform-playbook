#########################################################
# EBS CSI IAM POLICY
#########################################################

resource "aws_iam_policy" "this" {

  name = "AmazonEKS_EBS_CSI_Driver"

  description = "IAM policy for AWS EBS CSI Driver"

  policy = file(
    "${path.root}/../../policies/eks-ebs-csi.json"
  )

  tags = merge(

    var.tags,

    {
      Name = "AmazonEKS_EBS_CSI_Driver"
    }

  )

}


#########################################################
# EBS CSI IAM ROLE
#########################################################

resource "aws_iam_role" "this" {

  name = var.ebs_csi.service_account_role_name

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Federated = var.oidc_provider_arns[
            var.ebs_csi.cluster
          ]

        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {

          StringEquals = {

            "${replace(
              var.oidc_provider_urls[var.ebs_csi.cluster],
              "https://",
              ""
            )}:aud" = "sts.amazonaws.com"

            "${replace(
              var.oidc_provider_urls[var.ebs_csi.cluster],
              "https://",
              ""
            )}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"

          }

        }

      }

    ]

  })

  tags = merge(

    var.tags,

    {
      Name = var.ebs_csi.service_account_role_name
    }

  )

}


#########################################################
# POLICY ATTACHMENT
#########################################################

resource "aws_iam_role_policy_attachment" "this" {

  role = aws_iam_role.this.name

  policy_arn = aws_iam_policy.this.arn

}
