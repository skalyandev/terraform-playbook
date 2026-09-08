resource "aws_route_table_association" "this" {

  for_each = var.subnet_details

  subnet_id = each.value.id

  route_table_id = var.route_table_ids[
    each.value.route_table
  ]
}
