#########################################################
# EC2 INSTANCES
#########################################################

resource "aws_instance" "this" {

  for_each = var.instances

  # AMI
  ami = var.ami_ids[each.value.ami]
 
  user_data = try(
    file("${path.root}/${each.value.user_data_file}"),
    null
  )

  user_data_replace_on_change = each.value.user_data_replace_on_change
 
  # INSTANCE TYPE
  instance_type = each.value.instance_type

  # SUBNET
  subnet_id = var.subnet_ids[each.value.subnet]


  # SECURITY GROUPS
  vpc_security_group_ids = [

    for sg in each.value.security_groups :
    var.security_group_ids[sg]

  ]

  # IAM INSTANCE PROFILE
  iam_instance_profile = lookup(each.value, "iam_instance_profile", null) != null ? var.instance_profile_names[each.value.iam_instance_profile] : null

  # OPTIONAL PARAMETERS
  key_name = lookup(each.value, "key_name", null)
  associate_public_ip_address = lookup(each.value, "associate_public_ip", false)
  monitoring = lookup(each.value, "monitoring", false)
  ebs_optimized = lookup(each.value, "ebs_optimized", false)
  disable_api_termination = lookup(each.value, "disable_api_termination", false)

  # ROOT VOLUME
  dynamic "root_block_device" {

    for_each = lookup(each.value, "root_volume", null) != null ? [each.value.root_volume] : []

    content {
      volume_size = root_block_device.value.size
      volume_type = root_block_device.value.type
      encrypted = lookup(root_block_device.value, "encrypted", true)
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", true)
      iops = lookup(root_block_device.value, "iops", null)
      throughput = lookup(root_block_device.value, "throughput", null)
    }

  }

  # TAGS
  tags = merge(

    var.tags,
    lookup(each.value, "tags", {}),

    {
      Name = each.key
    }

  )

}
