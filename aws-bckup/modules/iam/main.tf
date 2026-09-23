#####################################################################################
# EC2 ASSUME ROLE POLICY
#####################################################################################

data "aws_iam_policy_document" "ec2_assume_role" {

  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}


####################################################################################
# s3 ACCESS POLICY
####################################################################################
resource "aws_iam_policy" "s3_access" {
  
  name  = "${var.name}-s3-access"
  description = "Allow Bastion Access to S3 Buckets"

  policy = jsonencode({
    
    Version  = "2012-10-17"

    Statement = [
      
      {
      Sid     = "AllowBastionRoleOnly"  
      Effect  = "Allow"

      Action  = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject" ] 
      
      Resource = [
        "${var.bucket_arn}/*" ]
     },

     {
        Sid    = "AllowBastionRoleList"
        Effect = "Allow"
      
        Action = [
          "s3:ListBucket",
           ]

        Resource = [ 
          "${var.bucket_arn}" ]
      }  
    ]
  })
}



#####################################################################################
# EKS DESCRIBE POLICY
#####################################################################################

resource "aws_iam_policy" "eks_describe" {

  name        = "${var.name}-eks-describe"
  description = "Allow bastion host to describe EKS clusters"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "eks:DescribeCluster"
        ]

        Resource = "*"
      }
    ]
  })
}

#####################################################################################
# BASTION IAM ROLE
#####################################################################################

resource "aws_iam_role" "bastion_role" {

  name               = "${var.name}-bastion-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = var.tags
}

#####################################################################################
# ATTACH EKS DESCRIBE POLICY TO ROLE
#####################################################################################

resource "aws_iam_role_policy_attachment" "eks_describe" {

  role       = aws_iam_role.bastion_role.name
  policy_arn = aws_iam_policy.eks_describe.arn
}

#####################################################################################
# ATTACH S3 POLICY
#####################################################################################

resource "aws_iam_role_policy_attachment" "s3_access" {

  role       = aws_iam_role.bastion_role.name
  policy_arn = aws_iam_policy.s3_access.arn
}

#####################################################################################
# INSTANCE PROFILE
#####################################################################################

resource "aws_iam_instance_profile" "bastion_profile" {

  name = "${var.name}-bastion-profile"
  role = aws_iam_role.bastion_role.name
}



