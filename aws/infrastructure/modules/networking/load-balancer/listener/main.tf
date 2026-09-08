#########################################################
# LOAD BALANCER LISTENERS
#########################################################

resource "aws_lb_listener" "this" {

  for_each = var.listeners

  #######################################################
  # LOAD BALANCER
  #######################################################

  load_balancer_arn = var.load_balancer_arns[
    each.value.load_balancer
  ]

  #######################################################
  # LISTENER
  #######################################################

  port     = each.value.port
  protocol = each.value.protocol

  #######################################################
  # HTTPS ONLY
  #######################################################

  certificate_arn = lookup(each.value, "certificate_arn", null)

  ssl_policy = lookup(each.value, "ssl_policy", null)

  #######################################################
  # DEFAULT ACTION - FORWARD
  #######################################################

  dynamic "default_action" {

    for_each = each.value.default_action.type == "forward" ? [1] : []

    content {

      type = "forward"

      target_group_arn = var.target_group_arns[
        each.value.default_action.target_group
      ]

    }

  }

  #######################################################
  # DEFAULT ACTION - REDIRECT
  #######################################################

  dynamic "default_action" {

    for_each = each.value.default_action.type == "redirect" ? [1] : []

    content {

      type = "redirect"

      redirect {

        port        = each.value.default_action.redirect.port
        protocol    = each.value.default_action.redirect.protocol
        status_code = each.value.default_action.redirect.status_code

      }

    }

  }

}
