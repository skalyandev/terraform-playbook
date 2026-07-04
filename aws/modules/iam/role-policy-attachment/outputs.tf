output "custom_policy_attachments" {

  value = aws_iam_role_policy_attachment.custom

}

output "managed_policy_attachments" {

  value = aws_iam_role_policy_attachment.managed

}
