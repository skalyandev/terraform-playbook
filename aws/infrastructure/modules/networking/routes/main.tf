resource "aws_route" "this" {

  for_each = var.routes

  route_table_id         = var.route_table_ids[each.value.route_table]
  destination_cidr_block = each.value.destination

  gateway_id = (
    each.value.target_type == "igw"
      ? var.internet_gateway_id
      : null
  )

  nat_gateway_id = (
    each.value.target_type == "nat"
      ? var.nat_gateway_ids[each.value.target_name]
      : null
  )
}
