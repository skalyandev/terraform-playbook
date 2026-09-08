resource "aws_security_group" "this" {

  for_each = var.security_groups

  name     = each.key

  description = each.value.description
  vpc_id = var.vpc_id
  tags = merge(
    var.tags,
    {
      Name = each.key
    }
  )

}

