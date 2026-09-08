#########################################################
# METRIC FILTER IDS
#########################################################

output "cloudtrail_metric_filter_ids" {

  description = "CloudWatch Log Metric Filter IDs."

  value = {
    for k, v in aws_cloudwatch_log_metric_filter.this :
    k => v.id
  }

}


#########################################################
# METRIC FILTER NAMES
#########################################################

output "cloudtrail_metric_filter_names" {

  description = "CloudWatch Log Metric Filter names."

  value = {
    for k, v in aws_cloudwatch_log_metric_filter.this :
    k => v.name
  }

}


#########################################################
# METRIC FILTER LOG GROUPS
#########################################################

output "cloudtrail_metric_filter_log_groups" {

  description = "CloudWatch Log Groups associated with each metric filter."

  value = {
    for k, v in aws_cloudwatch_log_metric_filter.this :
    k => v.log_group_name
  }

}
