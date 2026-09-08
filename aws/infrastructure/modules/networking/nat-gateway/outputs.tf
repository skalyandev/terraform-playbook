output "nat_gateway_ids" {

  description = "NAT Gateway IDs"

  value = {
    for k, v in aws_nat_gateway.this :
    k => v.id
  }
}

output "nat_gateway_public_ips" {

  description = "NAT Gateway Public IPs"

  value = {
    for k, v in aws_nat_gateway.this :
    k => v.public_ip
  }
}
