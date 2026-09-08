#########################################################
# CLOUDWATCH DASHBOARDS
#########################################################
locals {

  dashboard_body = {

    for key, dashboard in var.dashboards :
    key => templatefile(
      "${path.module}/templates/${dashboard.template}",
      merge(
        {
          region = var.region
        },
        dashboard.variables
      )
    )
  }
}



resource "aws_cloudwatch_dashboard" "this" {

  for_each = var.dashboards

  dashboard_name = each.value.dashboard_name
  dashboard_body = local.dashboard_body[each.key]
}
