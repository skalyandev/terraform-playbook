output "allocation_id" {
  value = aws_eip.this.id
}

output "elastic_public_ip" {
  value = aws_eip.this.public_ip
}
