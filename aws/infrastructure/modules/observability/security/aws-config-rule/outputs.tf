#########################################################
# AWS CONFIG RULE IDS
#########################################################

output "awsconfig_rule_ids" {

  description = "AWS Config rule IDs."

  value = {
    for k, v in aws_config_config_rule.this :
    k => v.id
  }

}


#########################################################
# AWS CONFIG RULE ARNS
#########################################################

output "awsconfig_rule_arns" {

  description = "AWS Config rule ARNs."

  value = {
    for k, v in aws_config_config_rule.this :
    k => v.arn
  }

}


#########################################################
# AWS CONFIG RULE NAMES
#########################################################

output "awsconfig_rule_names" {

  description = "AWS Config rule names."

  value = {
    for k, v in aws_config_config_rule.this :
    k => v.name
  }

}


#########################################################
# AWS CONFIG RULE DESCRIPTIONS
#########################################################

output "awsconfig_rule_descriptions" {

  description = "AWS Config rule descriptions."

  value = {
    for k, v in aws_config_config_rule.this :
    k => v.description
  }

}


#########################################################
# AWS CONFIG RULE COMPLIANCE TYPES
#########################################################

output "awsconfig_rule_resource_types" {

  description = "Resource types evaluated by each AWS Config rule."

  value = {
    for k, v in aws_config_config_rule.this :
    k => v.scope[*].compliance_resource_types
  }

}
