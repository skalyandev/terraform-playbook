#########################################################
# LOG GROUP NAMES
#########################################################

output "cloudwatch_log_group_names" {

  value = {
    for k, v in aws_cloudwatch_log_group.this :
    k => v.name
  }

}

#########################################################
# LOG GROUP ARNS
#########################################################

output "cloudwatch_log_group_arns" {

  value = {
    for k, v in aws_cloudwatch_log_group.this :
    k => v.arn
  }

}

#########################################################
# LOG GROUP IDS
#########################################################

output "cloudwatch_log_group_ids" {

  value = {
    for k, v in aws_cloudwatch_log_group.this :
    k => v.id
  }

}
