locals {

  associations = flatten([

    for subnet_type, subnet_ids in var.subnet_ids_by_type : [

      for subnet_id in subnet_ids : {

        subnet_id      = subnet_id
        route_table_id = var.route_table_ids[subnet_type]
      }
    ]
  ])
}

resource "aws_route_table_association" "this" {

  for_each = {

    for idx, association in local.associations :
    idx => association
  }

  subnet_id      = each.value.subnet_id
  route_table_id = each.value.route_table_id
}
