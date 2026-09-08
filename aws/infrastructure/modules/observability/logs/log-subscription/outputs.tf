#########################################################
# SUBSCRIPTION FILTER IDS
#########################################################

output "subscription_filter_ids" {

  description = "CloudWatch Log Subscription Filter IDs."

  value = {
    for k, v in aws_cloudwatch_log_subscription_filter.this :
    k => v.id
  }

}

#########################################################
# SUBSCRIPTION FILTER ARNS
#########################################################

output "subscription_filter_arns" {

  description = "CloudWatch Log Subscription Filter ARNs."

  value = {
    for k, v in aws_cloudwatch_log_subscription_filter.this :
    k => v.arn
  }

}

#########################################################
# SUBSCRIPTION FILTER NAMES
#########################################################

output "subscription_filter_names" {

  description = "CloudWatch Log Subscription Filter Names."

  value = {
    for k, v in aws_cloudwatch_log_subscription_filter.this :
    k => v.name
  }

}

#########################################################
# LOG GROUP NAMES
#########################################################

output "subscription_filter_log_groups" {

  description = "CloudWatch Log Groups associated with subscription filters."

  value = {
    for k, v in aws_cloudwatch_log_subscription_filter.this :
    k => v.log_group_name
  }

}

#########################################################
# DESTINATION ARNS
#########################################################

output "subscription_filter_destinations" {

  description = "Destination ARNs configured for subscription filters."

  value = {
    for k, v in aws_cloudwatch_log_subscription_filter.this :
    k => v.destination_arn
  }

}
