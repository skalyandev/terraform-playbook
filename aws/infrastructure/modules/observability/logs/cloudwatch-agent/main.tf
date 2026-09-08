#########################################################
# CLOUDWATCH AGENT INSTALLATION SSM DOCUMENT
#########################################################

resource "aws_ssm_document" "install" {

  for_each = {
    for k, v in var.cloudwatch_agents :
    k => v
    if v.install_agent
  }

  name = "${local.agent_names[each.key]}-install"

  document_type   = "Command"
  document_format = "JSON"

  content = templatefile(
    "${path.module}/templates/linux-ssm.json.tpl",
    {}
  )

  tags = merge(
    var.tags,
    try(each.value.tags, {}),
    {
      Name = "${local.agent_names[each.key]}-install"
    }
  )
}


#########################################################
# CLOUDWATCH AGENT CONFIGURATION
#
# STORED IN SSM PARAMETER STORE
#########################################################

resource "aws_ssm_parameter" "config" {

  for_each = var.cloudwatch_agents

  name = local.parameter_names[each.key]

  description = "CloudWatch Agent configuration for ${each.key}"

  type = "String"

  value = templatefile(
    "${path.module}/templates/linux-config.json.tpl",
    {}
  )

  tier = "Standard"

  tags = merge(
    var.tags,
    try(each.value.tags, {}),
    {
      Name = local.agent_names[each.key]
    }
  )
}


#########################################################
# INSTALL CLOUDWATCH AGENT
#########################################################

resource "aws_ssm_association" "install" {

  for_each = {
    for k, v in var.cloudwatch_agents :
    k => v
    if v.install_agent
  }

  name = aws_ssm_document.install[each.key].name

  association_name = "${local.agent_names[each.key]}-install"

  targets {
    key = "InstanceIds"

    values = [
      each.value.instance_id
    ]
  }
}


#########################################################
# CONFIGURE CLOUDWATCH AGENT
#########################################################

resource "aws_ssm_association" "configure" {

  for_each = var.cloudwatch_agents

  name = "AmazonCloudWatch-ManageAgent"

  association_name = local.agent_names[each.key]

  parameters = merge(

    {
      action = "configure"

      mode = each.value.mode

      optionalConfigurationSource = "ssm"

      optionalConfigurationLocation = aws_ssm_parameter.config[each.key].name

      optionalRestart = each.value.restart ? "yes" : "no"
    },

    each.value.parameters
  )

  targets {
    key = "InstanceIds"

    values = [
      each.value.instance_id
    ]
  }

  depends_on = [
    aws_ssm_parameter.config,
    aws_ssm_association.install
  ]
}
