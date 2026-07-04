output "route_table_ids" {

  description = "Route Table IDs"

  value = {
    for k, v in aws_route_table.this :
    k => v.id
  }
}
