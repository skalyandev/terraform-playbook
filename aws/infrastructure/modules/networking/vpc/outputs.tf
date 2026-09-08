output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "vpc_arn" {
  description = "VPC ARN"
  value       = aws_vpc.this.arn
}

output "vpc_cidr_block" {
  description = "VPC CIDR"
  value       = aws_vpc.this.cidr_block
}

output "default_route_table_id" {
  value = aws_vpc.this.default_route_table_id
}

output "default_network_acl_id" {
  value = aws_vpc.this.default_network_acl_id
}

output "default_security_group_id" {
  value = aws_vpc.this.default_security_group_id
}
