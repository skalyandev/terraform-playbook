#########################################################
# SNS SUBSCRIPTIONS
#########################################################

resource "aws_sns_topic_subscription" "this" {

  for_each = var.subscriptions

  topic_arn = var.topic_arns[each.value.topic]
  protocol = each.value.protocol
  endpoint = each.value.endpoint

}
