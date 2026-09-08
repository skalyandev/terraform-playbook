output "subnet_ids" {
  description = "Subnet IDs keyed by subnet name"

  value = {
    for name, subnet in aws_subnet.this :
    name => subnet.id
  }
}

output "subnet_lookup" {

  description = "Flat subnet lookup map"

  value = {
    for name, subnet in aws_subnet.this :
    name => subnet.id
  }

}

output "private_subnet_ids" {
  description = "Private subnet IDs grouped dynamically by purpose"

  value = {
    for purpose in distinct([
      for name, subnet in var.subnets :
      subnet.purpose
      if subnet.subnet_type == "private"
    ]) :

    purpose => {
      for name, subnet in aws_subnet.this :
      name => subnet.id
      if var.subnets[name].subnet_type == "private" &&
         var.subnets[name].purpose == purpose
    }
  }
}

output "public_subnet_ids" {
  description = "Public subnet IDs grouped dynamically by purpose"

  value = {
    for purpose in distinct([
      for name, subnet in var.subnets :
      subnet.purpose
      if subnet.subnet_type == "public"
    ]) :

    purpose => {
      for name, subnet in aws_subnet.this :
      name => subnet.id
      if var.subnets[name].subnet_type == "public" &&
         var.subnets[name].purpose == purpose
    }
  }
}

output "subnet_details" {
  description = "Subnet details keyed by subnet name"

  value = {
    for name, subnet in aws_subnet.this :
    name => {
      id                = subnet.id
      availability_zone = subnet.availability_zone
      subnet_type       = var.subnets[name].subnet_type
      route_table       = var.subnets[name].route_table
      cidr_block        = var.subnets[name].cidr_block
    }
  }
}
