#########################################################
# VPC FLOW LOG IDS
#########################################################

output "flow_log_ids" {

  description = "VPC Flow Log IDs"

  value = {

    for k, v in aws_flow_log.this :

    k => v.id

  }

}

#########################################################
# VPC FLOW LOG ARNS
#########################################################

output "flow_log_arns" {

  description = "VPC Flow Log ARNs"

  value = {

    for k, v in aws_flow_log.this :

    k => v.arn

  }

}

#########################################################
# VPC FLOW LOG NAMES
#########################################################

output "flow_log_names" {

  description = "VPC Flow Log Names"

  value = {

    for k, v in aws_flow_log.this :

    k => v.tags["Name"]

  }

}
