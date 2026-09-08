output "external_dns_role_arn" {
  value = aws_iam_role.external_dns.arn
}


output "external_dns_service_account" {
  value = kubernetes_service_account_v1.external_dns.metadata[0].name
}
