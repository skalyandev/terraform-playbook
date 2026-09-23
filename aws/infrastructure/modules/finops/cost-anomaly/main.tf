#########################################################
# AWS COST ANOMALY DETECTION MONITOR
#########################################################

resource "aws_ce_anomaly_monitor" "this" {

  name              = var.monitor_name
  monitor_type      = var.monitor_type
  monitor_dimension = var.monitor_dimension

  tags = local.common_tags
}

#########################################################
# AWS COST ANOMALY DETECTION SUBSCRIPTION
#########################################################

resource "aws_ce_anomaly_subscription" "this" {

  name      = var.subscription_name
  frequency = var.notification_frequency

  monitor_arn_list = [
    aws_ce_anomaly_monitor.this.arn
  ]

  dynamic "subscriber" {
    for_each = var.subscriber_email_addresses

    content {
      type    = "EMAIL"
      address = subscriber.value
    }
  }

  dynamic "subscriber" {
    for_each = var.subscriber_sns_topic_arns

    content {
      type    = "SNS"
      address = subscriber.value
    }
  }

  threshold_expression {

    and {
      dimension {
        key           = "ANOMALY_TOTAL_IMPACT_ABSOLUTE"
        match_options = ["GREATER_THAN_OR_EQUAL"]
        values        = [tostring(var.absolute_threshold)]
      }
    }

    and {
      dimension {
        key           = "ANOMALY_TOTAL_IMPACT_PERCENTAGE"
        match_options = ["GREATER_THAN_OR_EQUAL"]
        values        = [tostring(var.percentage_threshold)]
      }
    }
  }

  tags = local.common_tags
}

