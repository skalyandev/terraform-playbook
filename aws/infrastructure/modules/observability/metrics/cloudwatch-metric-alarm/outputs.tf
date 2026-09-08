#########################################################
# ALARM IDS
#########################################################

output "metric_alarm_ids" {

  value = {
    for k, v in aws_cloudwatch_metric_alarm.this :
    k => v.id
  }

}

#########################################################
# ALARM ARNS
#########################################################

output "metric_alarm_arns" {

  value = {

    for k, v in aws_cloudwatch_metric_alarm.this :

    k => v.arn

  }

}

#########################################################
# ALARM NAMES
#########################################################

output "metric_alarm_names" {

  value = {

    for k, v in aws_cloudwatch_metric_alarm.this :

    k => v.alarm_name

  }

}
