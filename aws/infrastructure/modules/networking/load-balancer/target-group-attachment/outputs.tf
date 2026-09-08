#########################################################
# TARGET GROUP ATTACHMENT IDS
#########################################################

output "target_group_attachment_ids" {

  description = "Target Group Attachment IDs"

  value = {
    for k, v in aws_lb_target_group_attachment.this :
    k => v.id
  }

}
