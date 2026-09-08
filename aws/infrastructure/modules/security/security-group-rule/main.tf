resource "aws_security_group_rule" "cidr" {

  for_each = {

    for k, v in local.rules_map :
    k => v
    if try(length(v.cidr_blocks), 0) > 0

  }

  security_group_id = var.security_group_ids[each.value.security_group]

  type = each.value.type
  protocol = each.value.protocol
  from_port = each.value.from_port
  to_port = each.value.to_port
  cidr_blocks = each.value.cidr_blocks
  description = each.value.description

}


resource "aws_security_group_rule" "ipv6" {

  for_each = {

    for k, v in local.rules_map :

    k => v

    if try(length(v.ipv6_cidr_blocks), 0) > 0

  }

  security_group_id = var.security_group_ids[each.value.security_group]

  type = each.value.type
  protocol = each.value.protocol
  from_port = each.value.from_port
  to_port = each.value.to_port
  ipv6_cidr_blocks = each.value.ipv6_cidr_blocks
  description = each.value.description

}

resource "aws_security_group_rule" "sg" {

  for_each = {

    for k, v in local.rules_map :

    k => v

    if try(v.source_security_group, null) != null

  }

  security_group_id = var.security_group_ids[each.value.security_group]

  type = each.value.type
  protocol = each.value.protocol
  from_port = each.value.from_port
  to_port = each.value.to_port
  source_security_group_id = var.security_group_ids[
    each.value.source_security_group
  ]
  description = each.value.description

}


resource "aws_security_group_rule" "self" {

  for_each = {

    for k, v in local.rules_map :

    k => v

    if try(v.self, false)

  }

  security_group_id = var.security_group_ids[each.value.security_group]

  type = each.value.type
  protocol = each.value.protocol
  from_port = each.value.from_port
  to_port = each.value.to_port
  self = true
  description = each.value.description

}

resource "aws_security_group_rule" "prefix_list" {

  for_each = {

    for k, v in local.rules_map :

    k => v

    if try(length(v.prefix_list_ids), 0) > 0

  }

  security_group_id = var.security_group_ids[each.value.security_group]

  type = each.value.type
  protocol = each.value.protocol
  from_port = each.value.from_port
  to_port = each.value.to_port
  prefix_list_ids = each.value.prefix_list_ids
  description = each.value.description

}















