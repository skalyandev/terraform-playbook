##################################
# VPC FLOW LOGS
##################################
resource "aws_flow_log" "this" {

  for_each = var.vpc_flow_logs

  vpc_id = each.value.vpc_id

  traffic_type = each.value.traffic_type

  log_destination_type = "cloud-watch-logs"

  log_group_name = each.value.log_group_name

  iam_role_arn = each.value.iam_role_arn

  max_aggregation_interval = each.value.max_aggregation_interval

  tags = merge(
    var.tags,
    {
      Name = each.key
    }
  )

}
