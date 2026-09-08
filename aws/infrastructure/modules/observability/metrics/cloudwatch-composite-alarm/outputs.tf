#########################################################
# COMPOSITE ALARM IDS
#########################################################

output "composite_alarm_ids" {

  description = "Map of CloudWatch Composite Alarm IDs."

  value = {

    for key, alarm in aws_cloudwatch_composite_alarm.this :

    key => alarm.id

  }

}

#########################################################
# COMPOSITE ALARM ARNS
#########################################################

output "composite_alarm_arns" {

  description = "Map of CloudWatch Composite Alarm ARNs."

  value = {

    for key, alarm in aws_cloudwatch_composite_alarm.this :

    key => alarm.arn

  }

}

#########################################################
# COMPOSITE ALARM NAMES
#########################################################

output "composite_alarm_names" {

  description = "Map of CloudWatch Composite Alarm names."

  value = {

    for key, alarm in aws_cloudwatch_composite_alarm.this :

    key => alarm.alarm_name

  }

}
