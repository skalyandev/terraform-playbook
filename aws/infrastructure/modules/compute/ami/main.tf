data "aws_ami" "this" {

  for_each = var.amis

  most_recent = each.value.most_recent

  owners = each.value.owners

  dynamic "filter" {

    for_each = each.value.filters

    content {

      name   = filter.value.name
      values = filter.value.values

    }

  }

}
