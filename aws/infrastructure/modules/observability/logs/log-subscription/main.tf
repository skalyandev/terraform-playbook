#########################################################
# CLOUDWATCH LOG SUBSCRIPTION FILTERS
#########################################################

resource "aws_cloudwatch_log_subscription_filter" "this" {

  for_each = var.log_subscriptions

  name = coalesce(
    each.value.filter_name,
    each.key
  )

  log_group_name = each.value.log_group_name
  filter_pattern = each.value.filter_pattern
  destination_arn = each.value.destination_arn
  distribution = each.value.distribution
}
