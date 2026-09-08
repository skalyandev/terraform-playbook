output "sns_subscription_arns" {

  value = {
    for k, v in aws_sns_topic_subscription.this :
    k => v.arn
  }

}
