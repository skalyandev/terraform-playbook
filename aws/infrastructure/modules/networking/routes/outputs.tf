output "route_ids" {

  description = "Route IDs"

  value = {
    for k, v in aws_route.this :
    k => v.id
  }
}
