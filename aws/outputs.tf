output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.public_subnets.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.private_subnets.private_subnet_ids
}

output "internet_gateway_id" {
  value = module.igw.internet_gateway_id
}

output "nat_gateway_id" {
  value = module.nat_gateway.nat_gateway_id
}

output "route_table_id" {
  value = module.route_table.route_table_id
}
