#########################################################
# AWS CONFIG REMEDIATION
#########################################################

resource "aws_config_remediation_configuration" "this" {

  for_each = {
    for k, v in var.remediations :
    k => v
    if v.enabled
  }

  #######################################################
  # CONFIG RULE
  #######################################################

  config_rule_name = each.value.config_rule_name

  #######################################################
  # REMEDIATION TARGET
  #######################################################

  target_type = each.value.target_type

  target_id = each.value.target_id

  target_version = each.value.target_version

  #######################################################
  # AUTOMATIC REMEDIATION
  #######################################################

  automatic = each.value.automatic

  #######################################################
  # RETRY CONFIGURATION
  #######################################################

  maximum_automatic_attempts = (
    each.value.automatic
    ? each.value.maximum_automatic_attempts
    : null
  )

  retry_attempt_seconds = (
    each.value.automatic
    ? each.value.retry_attempt_seconds
    : null
  )

  #######################################################
  # SSM PARAMETERS
  #######################################################

  dynamic "parameter" {

    for_each = each.value.parameters

    content {

      name = parameter.key

      static_value = (
        parameter.value.static_value
      )

      resource_value = (
        parameter.value.resource_value
      )

    }

  }

}
