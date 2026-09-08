#########################################################
# CLOUDWATCH LOG METRIC FILTERS
#########################################################

resource "aws_cloudwatch_log_metric_filter" "this" {

  for_each = var.metric_filters

  #######################################################
  # LOG GROUP
  #######################################################

  name = each.key

  log_group_name = each.value.log_group_name

  #######################################################
  # FILTER
  #######################################################

  pattern = each.value.filter_pattern

  #######################################################
  # METRIC TRANSFORMATION
  #######################################################

  metric_transformation {

    name = each.value.metric_name
    namespace = each.value.metric_namespace
    value = each.value.metric_value
    default_value = each.value.default_value
    dimensions = each.value.metric_dimensions

  }

}
