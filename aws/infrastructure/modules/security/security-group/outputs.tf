######################################################
# SECURITY GROUP IDS
######################################################

output "security_group_ids" {

  description = "Map of Security Group IDs"

  value = {
    for k, v in aws_security_group.this :
    k => v.id
  }

}

######################################################
# SECURITY GROUP ARNS
######################################################

output "security_group_arns" {

  description = "Map of Security Group ARNs"

  value = {
    for k, v in aws_security_group.this :
    k => v.arn
  }

}

######################################################
# SECURITY GROUP NAMES
######################################################

output "security_group_names" {

  description = "Map of Security Group Names"

  value = {
    for k, v in aws_security_group.this :
    k => v.name
  }

}

######################################################
# COMPLETE SECURITY GROUP OBJECTS
######################################################

output "security_groups" {

  description = "Complete Security Group resource objects"

  value = aws_security_group.this

}
