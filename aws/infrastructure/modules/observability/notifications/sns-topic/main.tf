#########################################################
# SNS TOPICS
#########################################################

resource "aws_sns_topic" "this" {

  for_each = var.topics

  name = each.key

  display_name = try(each.value.display_name, null)
  fifo_topic = try(each.value.fifo_topic, false)
  tags = merge(
    var.tags,
    {
      Name = each.key
    }
  )

}
