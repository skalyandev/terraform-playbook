output "instance_profile_ids" {

  value = {
    for k, v in aws_iam_instance_profile.this :
    k => v.id
  }

}

output "instance_profile_names" {

  value = {
    for k, v in aws_iam_instance_profile.this :
    k => v.name
  }

}

output "instance_profile_arns" {

  value = {
    for k, v in aws_iam_instance_profile.this :
    k => v.arn
  }

}
