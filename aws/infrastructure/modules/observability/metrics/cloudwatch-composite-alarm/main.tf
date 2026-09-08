#########################################################
# CLOUDWATCH COMPOSITE ALARMS
#########################################################

resource "aws_cloudwatch_composite_alarm" "this" {

  for_each = var.composite_alarms

  #####################################################
  # Alarm
  #####################################################

  alarm_name        = each.value.alarm_name

  alarm_description = try(each.value.alarm_description, null)

  #####################################################
  # Alarm Rule
  #####################################################

  alarm_rule = each.value.alarm_rule

  #####################################################
  # Actions
  #####################################################

  actions_enabled = each.value.actions_enabled

  alarm_actions = (
    try(each.value.sns_topic, null) != null
    ? [lookup(var.sns_topic_arns, each.value.sns_topic)]
    : []
  )

  ok_actions = (
    try(each.value.sns_topic, null) != null
    ? [lookup(var.sns_topic_arns, each.value.sns_topic)]
    : []
  )

  insufficient_data_actions = []

  #####################################################
  # Tags
  #####################################################

  tags = merge(
    var.tags,
    {
      Name = each.value.alarm_name
    }
  )

}
