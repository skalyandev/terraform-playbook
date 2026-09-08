#########################################################
# DASHBOARD NAMES
#########################################################

output "dashboard_names" {

  value = {

    for k, v in aws_cloudwatch_dashboard.this :

    k => v.dashboard_name

  }

}

#########################################################
# DASHBOARD ARNS
#########################################################

output "dashboard_arns" {

  value = {

    for k, v in aws_cloudwatch_dashboard.this :

    k => v.dashboard_arn

  }

}
