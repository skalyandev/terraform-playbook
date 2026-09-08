#########################################################
# AWS CONFIG REMEDIATION IDS
#########################################################

output "remediation_ids" {

  description = "AWS Config remediation configuration IDs."

  value = {
    for k, v in aws_config_remediation_configuration.this :
    k => v.id
  }

}


#########################################################
# AWS CONFIG RULE NAMES
#########################################################

output "remediation_config_rule_names" {

  description = "AWS Config rule names associated with remediation."

  value = {
    for k, v in aws_config_remediation_configuration.this :
    k => v.config_rule_name
  }

}


#########################################################
# REMEDIATION TARGET TYPES
#########################################################

output "remediation_target_types" {

  description = "Remediation target types."

  value = {
    for k, v in aws_config_remediation_configuration.this :
    k => v.target_type
  }

}


#########################################################
# REMEDIATION TARGET IDS
#########################################################

output "remediation_target_ids" {

  description = "SSM Automation document IDs used for remediation."

  value = {
    for k, v in aws_config_remediation_configuration.this :
    k => v.target_id
  }

}


#########################################################
# AUTOMATIC REMEDIATION
#########################################################

output "remediation_automatic" {

  description = "Whether automatic remediation is enabled."

  value = {
    for k, v in var.remediations :
    k => v.automatic
  }

}
