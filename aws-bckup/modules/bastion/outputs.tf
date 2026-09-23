
output "ami_id" {
  value = data.aws_ami.amazon_linux_2023.id
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion_sg.id
}

output "bastion_instance_id" {
  value = aws_instance.bastion.id
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion_elastic_ip" {
  value = aws_eip.bastion_eip.public_ip
}
