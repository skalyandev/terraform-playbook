output "kms_key_arn" {
  value = aws_kms_key.eks.arn
}

output "kms_key_id" {
  value = aws_kms_key.eks.key_id
}

output "kms_alias" {
  value = aws_kms_alias.eks.name
}
