#output "allocation_id" {
#  value = aws_eip.this.id
#}

#output "elastic_public_ip" {
#  value = aws_eip.this.public_ip
#}

output "allocation_ids" {
  description = "Elastic IP allocation IDs keyed by NAT name"

  value = {
    for k, v in aws_eip.this :
    k => v.id
  }
}

output "elastic_public_ips" {
  description = "Elastic IP public addresses keyed by NAT name"

  value = {
    for k, v in aws_eip.this :
    k => v.public_ip
  }
}
