#########################################################
# AWS CONFIG RULES
#########################################################

resource "aws_config_config_rule" "this" {

  for_each = {
    for k, v in var.config_rules :
    k => v
    if v.enabled
  }

  #######################################################
  # RULE
  #######################################################

  name = coalesce(each.value.name,each.key)

  description = each.value.description

  #######################################################
  # EVALUATION FREQUENCY
  #######################################################

  maximum_execution_frequency = ( each.value.maximum_execution_frequency )

  #######################################################
  # RULE SOURCE
  #######################################################

  source {

    owner = "AWS"

    source_identifier = ( each.value.source_identifier )

  }

  #######################################################
  # RULE SCOPE
  #######################################################

  scope {

    compliance_resource_types = ( length(each.value.compliance_resource_types) > 0 ? each.value.compliance_resource_types : null )

    tag_key = each.value.tag_key

    tag_value = each.value.tag_value

  }

  #######################################################
  # INPUT PARAMETERS
  #######################################################

  input_parameters = ( length(each.value.input_parameters) > 0 ? jsonencode(each.value.input_parameters) : null )

}
