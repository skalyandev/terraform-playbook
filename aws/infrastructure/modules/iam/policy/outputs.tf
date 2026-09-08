output "policy_arns" {

  value = {
    for k, v in aws_iam_policy.this :
    k => v.arn
  }

}

output "policy_names" {

  value = {
    for k, v in aws_iam_policy.this :
    k => v.name
  }

}

output "policy_ids" {

  value = {
    for k, v in aws_iam_policy.this :
    k => v.id
  }

}
