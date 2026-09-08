resource "aws_route_table" "this" {

  for_each = var.route_tables

  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = each.key
      Type = each.value.route_type
      AZ   = each.value.availability_zone
    }
  )
}
