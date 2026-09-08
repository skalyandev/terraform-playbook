output "volume_attachment_ids" {

  value = {
    for k, v in aws_volume_attachment.this :
    k => v.id
  }

}
