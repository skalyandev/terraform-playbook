#########################################################
# EBS VOLUME ATTACHMENTS
#########################################################

resource "aws_volume_attachment" "this" {

  for_each = var.volume_attachments

  device_name = each.value.device_name
  instance_id = var.instance_ids[each.value.instance]
  volume_id = var.volume_ids[each.value.volume]
  force_detach = each.value.force_detach
  skip_destroy = each.value.skip_destroy

}
