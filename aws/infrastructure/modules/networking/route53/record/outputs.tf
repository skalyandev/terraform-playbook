output "fqdn" {
  description = "Route53 record FQDNs."

  value = {
    for k, v in aws_route53_record.this :
    k => v.fqdn
  }
}
