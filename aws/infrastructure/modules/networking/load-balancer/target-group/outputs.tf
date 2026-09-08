#########################################################
# TARGET GROUP IDS
#########################################################

output "target_group_ids" {

  value = {
    for k, v in aws_lb_target_group.this :
    k => v.id
  }
}

#########################################################
# TARGET GROUP ARNS
#########################################################

output "target_group_arns" {

  value = {
    for k, v in aws_lb_target_group.this :
    k => v.arn
  }

}

#########################################################
# TARGET GROUP NAMES
#########################################################

output "target_group_names" {

  value = {
    for k, v in aws_lb_target_group.this :
    k => v.name
  }

}

#########################################################
# TARGET GROUP ARN SUFFIX
#########################################################

output "target_group_arn_suffix" {

  value = {
    for k, v in aws_lb_target_group.this :
    k => v.arn_suffix
  }

}




