locals {

  processed_routes = {

    for route_name, route in var.routes :

    route_name => {

      route_table_id = var.route_table_ids[
        route.route_table
      ]

      destination = route.destination

      target_type = route.target_type

      target_id = (
        route.target_type == "igw"
        ? var.internet_gateway_id

        : route.target_type == "nat"
        ? var.nat_gateway_ids[route.target_name]

        : null
      )
    }
  }
}

resource "aws_route" "this" {

  for_each = local.processed_routes

  route_table_id         = each.value.route_table_id
  destination_cidr_block = each.value.destination

  gateway_id = (
    each.value.target_type == "igw"
      ? each.value.target_id
      : null
  )

  nat_gateway_id = (
    each.value.target_type == "nat"
      ? each.value.target_id
      : null
  )
}
