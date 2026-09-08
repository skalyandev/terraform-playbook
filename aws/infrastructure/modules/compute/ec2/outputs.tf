#########################################################
# INSTANCE IDS
#########################################################

output "instance_ids" {

  description = "Map of EC2 Instance IDs"

  value = {

    for k, v in aws_instance.this :

    k => v.id

  }

}

#########################################################
# INSTANCE ARNS
#########################################################

output "instance_arns" {

  description = "Map of EC2 Instance ARNs"

  value = {

    for k, v in aws_instance.this :

    k => v.arn

  }

}

#########################################################
# PRIVATE IPS
#########################################################

output "private_ips" {

  description = "Map of Private IPs"

  value = {

    for k, v in aws_instance.this :

    k => v.private_ip

  }

}

#########################################################
# PUBLIC IPS
#########################################################

output "public_ips" {

  description = "Map of Public IPs"

  value = {

    for k, v in aws_instance.this :

    k => v.public_ip

  }

}

#########################################################
# AVAILABILITY ZONES
#########################################################

output "availability_zones" {

  description = "Map of Availability Zones"

  value = {

    for k, v in aws_instance.this :

    k => v.availability_zone

  }

}

#########################################################
# INSTANCE STATES
#########################################################

output "instance_states" {

  description = "Map of Instance States"

  value = {

    for k, v in aws_instance.this :

    k => v.instance_state

  }

}

#########################################################
# COMPLETE EC2 OBJECTS
#########################################################

output "instances" {

  description = "Complete EC2 Resources"

  value = aws_instance.this

}
