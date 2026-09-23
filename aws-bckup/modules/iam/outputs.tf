output "instance_profile_name" {
  value = aws_iam_instance_profile.bastion_profile.name
}

output "role_name" {
  value = aws_iam_role.bastion_role.name
}

output "bastion_role_arn" {
  value = aws_iam_role.bastion_role.arn
}
