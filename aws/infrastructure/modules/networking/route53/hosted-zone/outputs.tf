output "zone_id" {
  description = "Route53 Hosted Zone ID."
  value       = aws_route53_zone.this.zone_id
}

output "zone_name" {
  description = "Hosted Zone name."
  value       = aws_route53_zone.this.name
}

output "name_servers" {
  description = "Authoritative name servers for the hosted zone."
  value       = aws_route53_zone.this.name_servers
}

output "arn" {
  description = "Hosted Zone ARN."
  value       = aws_route53_zone.this.arn
}
