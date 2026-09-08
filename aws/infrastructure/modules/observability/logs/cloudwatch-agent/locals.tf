#########################################################
# CLOUDWATCH AGENT LOCALS
#########################################################

locals {

  agent_names = {

    for k, v in var.cloudwatch_agents :

    k => "cloudwatch-agent-${k}"
  }


  parameter_names = {

    for k, v in var.cloudwatch_agents :

    k => coalesce(
      try(v.ssm_parameter_name, null),
      "/amazon-cloudwatch-agent/${k}"
    )
  }
}
