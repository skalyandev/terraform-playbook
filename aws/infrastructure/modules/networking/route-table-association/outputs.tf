output "association_ids" {

  value = {
    for k, v in aws_route_table_association.this :
    k => v.id
  }
}
