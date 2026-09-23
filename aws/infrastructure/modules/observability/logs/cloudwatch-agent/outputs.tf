#########################################################
# SSM PARAMETER NAMES
#########################################################

output "ssm_parameter_names" {

  description = "CloudWatch Agent SSM Parameter names"

  value = {
    for k, v in aws_ssm_parameter.config :
    k => v.name
  }
}


#########################################################
# SSM PARAMETER ARNS
#########################################################

output "ssm_parameter_arns" {

  description = "CloudWatch Agent SSM Parameter ARNs"

  value = {
    for k, v in aws_ssm_parameter.config :
    k => v.arn
  }
}


#########################################################
# INSTALL + CONFIGURATION DOCUMENT NAMES
#########################################################

output "install_document_names" {

  description = "CloudWatch Agent install and configuration SSM documents"

  value = {
    for k, v in aws_ssm_document.install :
    k => v.name
  }
}


#########################################################
# INSTALL + CONFIGURATION ASSOCIATION IDS
#########################################################

output "association_ids" {

  description = "CloudWatch Agent install and configuration association IDs"

  value = {
    for k, v in aws_ssm_association.install :
    k => v.association_id
  }
}


#########################################################
# AGENT NAMES
#########################################################

output "agent_names" {

  description = "CloudWatch Agent names"

  value = local.agent_names
}
