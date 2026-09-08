resource "aws_ebs_volume" "this" {

  for_each = var.ebs_volumes

  availability_zone = each.value.availability_zone
  size = each.value.size
  type = each.value.type
  encrypted = each.value.encrypted
  kms_key_id = try(each.value.kms_key_id, null)
  snapshot_id = try(each.value.snapshot_id, null)
  iops = try(each.value.iops, null)
  throughput = try(each.value.throughput, null)
  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name = each.key
    }
  )
}
