#########################################################
# SNS TOPIC ARNS
#########################################################

output "sns_topic_arns" {

  value = {
    for k, v in aws_sns_topic.this :
    k => v.arn
  }

}

#########################################################
# SNS TOPIC IDS
#########################################################

output "sns_topic_ids" {

  value = {
    for k, v in aws_sns_topic.this :
    k => v.id
  }

}

#########################################################
# SNS TOPIC NAMES
#########################################################

output "sns_topic_names" {

  value = {
    for k, v in aws_sns_topic.this :
    k => v.name
  }
}
