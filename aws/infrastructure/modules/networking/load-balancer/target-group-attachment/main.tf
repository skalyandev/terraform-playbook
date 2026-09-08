#########################################################
# TARGET GROUP ATTACHMENTS
#########################################################

resource "aws_lb_target_group_attachment" "this" {

  for_each = var.target_group_attachments

  #######################################################
  # TARGET GROUP
  #######################################################

  target_group_arn = var.target_group_arns[
    each.value.target_group
  ]

  #######################################################
  # TARGET
  #######################################################

  target_id = var.instance_ids[
    each.value.instance
  ]

  #######################################################
  # APPLICATION PORT
  #######################################################

  port = each.value.port

}
