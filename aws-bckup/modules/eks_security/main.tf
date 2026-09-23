resource "aws_kms_key" "eks" {

  description             = "KMS key for EKS Secrets Encryption"
  deletion_window_in_days = 7

  enable_key_rotation = true

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-eks-kms-key"
    }
  )
}

resource "aws_kms_alias" "eks" {

  name = "alias/${var.environment}-eks"

  target_key_id = aws_kms_key.eks.key_id
}
