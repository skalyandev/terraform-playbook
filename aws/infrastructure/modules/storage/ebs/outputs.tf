output "ebs_volume_ids" {

  value = {
    for k, v in aws_ebs_volume.this :
    k => v.id
  }

}

output "ebs_volume_arns" {

  value = {
    for k, v in aws_ebs_volume.this :
    k => v.arn
  }

}

output "ebs_volume_azs" {

  value = {
    for k, v in aws_ebs_volume.this :
    k => v.availability_zone
  }

}
