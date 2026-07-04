locals {
  applications = distinct([
    for name, subnet in var.subnets :
    split("-", name)[0]
  ])
}


output "public_subnet_ids" {
  value = {
    for app in local.applications :

    app => {
      for name, subnet in aws_subnet.this :
      
      name => subnet.id

      if split("-", name)[0] == app &&
         var.subnets[name].subnet_type == "public"
    }
  }
}


output "private_subnet_ids" {
  value = {
    for app in local.applications :

    app => {
      for name, subnet in aws_subnet.this :
      
      name => subnet.id

      if split("-", name)[0] == app &&
         var.subnets[name].subnet_type == "private"
    }
  }
}

#output "public_subnet_ids" {
#  value = {
#    for k, v in aws_subnet.this :
#    k => v.id
#    if var.subnets[k].subnet_type == "public"
#  }
#}

#output "private_subnet_ids" {
#  value = {
#    for k, v in aws_subnet.this :
#    k => v.id
#    if var.subnets[k].subnet_type == "private"
#  }
#}

output "eks_private_subnet_ids" {

  value = {
    for k, v in aws_subnet.this :
    k => v.id
    if var.subnets[k].subnet_type == "private"
  }

}


output "subnet_route_tables" {
  value = {
    for k, v in var.subnets :
    k => v.route_table
  }
}


output "subnet_ids_by_type" {

  value = {
    for subnet_type in distinct([
      for subnet in values(var.subnets) : subnet.subnet_type
    ]) :

    subnet_type => [
      for k, v in aws_subnet.this :
      v.id
      if var.subnets[k].subnet_type == subnet_type
    ]
  }
}
