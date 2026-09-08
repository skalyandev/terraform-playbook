#########################################################
# CLOUDWATCH METRIC ALARMS
#########################################################
resource "aws_cloudwatch_metric_alarm" "this" {

  for_each = var.metric_alarms

  #####################################################
  # Alarm
  #####################################################

  alarm_name        = each.value.alarm_name
  alarm_description = try(each.value.alarm_description, null)

  #####################################################
  # Metric
  #####################################################

  namespace   = each.value.namespace
  metric_name = each.value.metric_name
  dimensions = each.value.dimensions

  #####################################################
  # Evaluation
  #####################################################

  comparison_operator = each.value.comparison_operator
  evaluation_periods = each.value.evaluation_periods
  threshold = each.value.threshold
  period = each.value.period

  #####################################################
  # Statistics
  #####################################################

  statistic = try(each.value.statistic, null)
  extended_statistic = try(each.value.extended_statistic, null)
  unit = try(each.value.unit, null)

  #####################################################
  # Advanced
  #####################################################

  datapoints_to_alarm = try(each.value.datapoints_to_alarm, null)
  treat_missing_data = each.value.treat_missing_data
  actions_enabled = each.value.actions_enabled

  #####################################################
  # Notifications
  #####################################################

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
