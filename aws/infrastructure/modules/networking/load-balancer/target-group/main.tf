#########################################################
# TARGET GROUPS
#########################################################

resource "aws_lb_target_group" "this" {

  for_each = var.target_groups

  #####################################################
  # Basic Configuration
  #####################################################

  name = each.key
  port = each.value.port
  protocol = upper(each.value.protocol)
  vpc_id = var.vpc_id
  target_type = each.value.target_type

  #####################################################
  # Optional Configuration
  #####################################################

  deregistration_delay = each.value.deregistration_delay
  load_balancing_algorithm_type = each.value.load_balancing_algorithm

  #####################################################
  # Health Check
  #####################################################

  health_check {

    enabled = each.value.health_check.enabled
    protocol = upper(each.value.health_check.protocol)
    path = each.value.health_check.path
    port = each.value.health_check.port
    interval = each.value.health_check.interval
    timeout = each.value.health_check.timeout
    healthy_threshold = each.value.health_check.healthy_threshold
    unhealthy_threshold = each.value.health_check.unhealthy_threshold
    matcher = each.value.health_check.matcher

  }

  #####################################################
  # Tags
  #####################################################

  tags = merge(

    var.tags,
    {
      Name = each.key
    }
  )

}
