resource "aws_lb" "this" {

  for_each = var.load_balancers

  #######################################################
  # BASIC SETTINGS
  #######################################################

  name               = each.key
  internal           = each.value.internal
  load_balancer_type = each.value.load_balancer_type

  #######################################################
  # SUBNETS
  #######################################################

  subnets = [

    for subnet in each.value.subnets :

    var.subnet_ids[subnet]

  ]

  #######################################################
  # SECURITY GROUPS
  #######################################################

  security_groups = [

    for sg in each.value.security_groups :

    var.security_group_ids[sg]

  ]

  #######################################################
  # ADVANCED SETTINGS
  #######################################################

  idle_timeout               = each.value.idle_timeout
  enable_deletion_protection = each.value.enable_deletion_protection
  enable_http2               = each.value.enable_http2
  ip_address_type            = each.value.ip_address_type

  #######################################################
  # TAGS
  #######################################################

  tags = merge(

    var.tags,

    each.value.tags,

    {
      Name = each.key
    }

  )

}
