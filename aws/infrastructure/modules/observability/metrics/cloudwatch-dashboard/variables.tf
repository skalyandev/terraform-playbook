#########################################################
# CLOUDWATCH DASHBOARD VARIABLES
#########################################################

variable "region" {

  description = "AWS region"
  type = string

}


variable "dashboards" {

  description = "CloudWatch dashboard configuration"

  type = map(object({
    dashboard_name = string
    template = string
    variables = optional(
      map(string),
      {}
    )

  }))

  validation {
    condition = length(var.dashboards) > 0
    error_message = "At least one CloudWatch dashboard must be configured."
  }

}
