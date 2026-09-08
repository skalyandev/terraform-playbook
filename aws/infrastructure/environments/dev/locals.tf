#########################################################
# COMMON TAGS
#########################################################

locals {

  name_prefix = "vodafone-dev"

  common_tags = {
    Environment = "dev"
    Project     = "boutique"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}


#########################################################
# EC2 LOOKUP TABLES
#########################################################

locals {

  ec2_instance_ids = merge(
    module.public_ec2.instance_ids,
    module.private_ec2.instance_ids
  )

}

#########################################################
# ROUTE 53 RECORD
#########################################################
locals {

  route53_records = {
    for k, v in var.route53_records :

    k => {
      name         = v.name
      alb_dns_name = module.load_balancers.alb_dns_names[k]
      alb_zone_id  = module.load_balancers.alb_zone_ids[k]
    }
  }

}

#########################################################
# ACM RECORD
#########################################################
locals {

  listeners = {

    jenkins-http = {

      load_balancer = "jenkins"

      port     = 80
      protocol = "HTTP"

      default_action = {
        type = "redirect"

        redirect = {
          port        = "443"
          protocol    = "HTTPS"
          status_code = "HTTP_301"
        }
      }
    }

    jenkins-https = {

      load_balancer = "jenkins"

      port     = 443
      protocol = "HTTPS"

      certificate_arn = module.acm.certificate_arn
      ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"

      default_action = {
        type         = "forward"
        target_group = "jenkins"
      }
    }

    nginx-http = {

      load_balancer = "nginx"

      port     = 80
      protocol = "HTTP"

      default_action = {
        type         = "forward"
        target_group = "nginx"
      }
    }
  }
}

#########################################################
# EC2 INSTANCE IDS
#########################################################

locals {

  observability_instance_ids = {
    bastion = module.public_ec2.instance_ids["bastion-ec2-server-ap-south-a"]
    bastion = module.public_ec2.instance_ids["bastion-ec2-server-ap-south-b"]
    jenkins = module.private_ec2.instance_ids["jenkins-ec2-server-ap-south-a"]
  }

}


#########################################################
# CLOUDWATCH AGENTS
#########################################################
locals {

  cloudwatch_agents = {

    for name, config in var.cloudwatch_agents :

    name => merge(
      config,
      {
        instance_id = local.observability_instance_ids[name]
      }
    )
  }
}



#########################################################
# CLOUDWATCH DASHBOARDS
#########################################################
locals {

  cloudwatch_dashboards = {

    jenkins = {
      dashboard_name = "dev-jenkins-dashboard"
      template       = "compute/jenkins.json.tpl"
      variables = {
        instance_id = module.private_ec2.instance_ids["jenkins-ec2-server-ap-south-a"]
      }
    }


    alb = {
      dashboard_name = "dev-alb-dashboard"
      template       = "network/alb.json.tpl"
      variables = {
        alb_suffix = module.load_balancers.alb_arn_suffix["jenkins"]
      }
    }
  }

}

#########################################################
# CLOUDWATCH METRIC ALARMS
#########################################################
locals {

  cloudwatch_metric_alarms = {

    jenkins_cpu = {

      alarm_name          = "dev-jenkins-high-cpu"
      alarm_description   = "Jenkins EC2 CPU utilization is high"
      comparison_operator = "GreaterThanThreshold"

      evaluation_periods = 2
      period             = 300
      threshold          = 80

      namespace   = "AWS/EC2"
      metric_name = "CPUUtilization"
      statistic   = "Average"

      dimensions = {
        InstanceId = module.private_ec2.instance_ids["jenkins-ec2-server-ap-south-a"]
      }

      sns_topic = "cloudwatch-alerts"
    }

    jenkins_memory = {

      alarm_name          = "dev-jenkins-high-memory"
      alarm_description   = "Jenkins EC2 memory utilization is high"
      comparison_operator = "GreaterThanThreshold"

      evaluation_periods = 2
      period             = 300
      threshold          = 80

      namespace   = "CWAgent"
      metric_name = "mem_used_percent"
      statistic   = "Average"

      dimensions = {
        InstanceId = module.private_ec2.instance_ids["jenkins-ec2-server-ap-south-a"]
      }

      sns_topic = "cloudwatch-alerts"
    }

  }
}




#########################################################
# CLOUDWATCH COMPOSITE ALARMS
#########################################################
locals {

  cloudwatch_composite_alarms = {

    jenkins_critical = {

      alarm_name        = "dev-jenkins-critical"
      alarm_description = "Critical Jenkins Alarm"

      alarm_rule = "ALARM(\"dev-jenkins-high-cpu\") AND ALARM(\"dev-jenkins-high-memory\")"

      sns_topic = "cloudwatch-alerts"
    }
  }
}



#########################################################
# CLOUDWATCH VPC FLOW LOGS
#########################################################
locals {

  vpc_flow_logs = {

    main = {
      ####################################################
      # VPC
      ####################################################

      vpc_id = module.vpc.vpc_id

      ####################################################
      # CloudWatch
      ####################################################

      log_group_name = module.cloudwatch_log_groups.cloudwatch_log_group_names["vpc-flow-logs"]

      ####################################################
      # IAM
      ####################################################

      iam_role_arn = module.iam_roles.role_arns["vpc-flow-logs"]

      ####################################################
      # Logging
      ####################################################

      traffic_type = "ALL"

      max_aggregation_interval = 600

    }

  }

}


#########################################################
# CLOUDWATCH LOG SUBSCRIPTION
#########################################################
locals {
  log_subscriptions = {

    vpc-flow-logs = {

      log_group_name  = "/aws/vpc/flow-logs"
      filter_pattern  = ""
      destination_arn = "arn:aws:kinesis:ap-south-1:123456789012:stream/log-stream"
      distribution    = "ByLogStream"

    }

    jenkins = {

      log_group_name  = "/aws/ec2/jenkins"
      filter_pattern  = ""
      destination_arn = "arn:aws:kinesisfirehose:ap-south-1:123456789012:deliverystream/log-stream"

    }
  }
}

#########################################################
# KINESIS DATA FIREHOSE
#########################################################
#locals {
#  firehose_streams = {

#    application_logs = {

#      name = "dev-application-logs"
#      destination = "extended_s3"
#      bucket_arn = module.s3_buckets.bucket_arns["logs"]
#      buffer_size = 5
#      buffer_interval = 300
#      compression_format = "GZIP"
#      error_output_prefix = "errors/"

#    }
#  }
#}


#########################################################
# CLOUDTRAIL
#########################################################
locals {

  cloudtrail_trails = {
    management = {

      name                          = "dev-management-trail"
      s3_bucket_name                = module.s3_buckets.bucket_names["cloudtrail-logs"]
      cloudwatch_log_group_arn      = module.cloudwatch_log_groups.cloudwatch_log_group_arns["cloudtrail"]
      include_global_service_events = true
      is_multi_region_trail         = true
      enable_log_file_validation    = true
      is_organization_trail         = false
      include_management_events     = true
      read_write_type               = "All"
    }
  }
}

#########################################################
# AWS CONFIG
#########################################################
locals {

  aws_config = merge(

    var.aws_config,

    {

      role_arn = (
        var.aws_config.enabled
        ? module.iam_roles.role_arns["aws-config"]
        : null
      )

      s3_bucket_name = (
        var.aws_config.enabled
        ? module.s3_buckets.bucket_names["centralized-logs"]
        : null
      )

    }

  )

}

#########################################################
# AWS CONFIG REMEDIATION
#########################################################

locals {

  aws_config_remediations = var.remediations

}


#########################################################
# AWS SECURITY HUB
#########################################################

locals {

  security_hub = var.security_hub

}


#########################################################
# FLUENT BIT
#########################################################

locals {

  fluent_bit = {

    enabled              = var.fluent_bit.enabled
    namespace            = var.fluent_bit.namespace
    service_account_name = var.fluent_bit.service_account_name

    #####################################################
    # IRSA
    #####################################################

    irsa_role_arn = var.fluent_bit.irsa_role_arn

    #####################################################
    # IMAGE
    #####################################################

    image_repository = var.fluent_bit.image_repository
    image_tag        = var.fluent_bit.image_tag

    #####################################################
    # CLOUDWATCH
    #####################################################

    log_group_name    = var.fluent_bit.log_group_name
    log_stream_prefix = var.fluent_bit.log_stream_prefix
    region            = var.fluent_bit.region

    #####################################################
    # LOG COLLECTION
    #####################################################

    read_from_head = var.fluent_bit.read_from_head
    db             = var.fluent_bit.db

    #####################################################
    # RESOURCES
    #####################################################

    cpu_request    = var.fluent_bit.cpu_request
    memory_request = var.fluent_bit.memory_request
    cpu_limit      = var.fluent_bit.cpu_limit
    memory_limit   = var.fluent_bit.memory_limit

    #####################################################
    # TOLERATIONS
    #####################################################

    tolerate_all = var.fluent_bit.tolerate_all

    #####################################################
    # TAGS
    #####################################################

    tags = merge(
      local.common_tags,
      var.fluent_bit.tags
    )

  }

}


#########################################################
# OPENTELEMETRY
#########################################################

locals {

  opentelemetry = var.opentelemetry

}


#########################################################
# FLUENT BIT IRSA ROLE
#########################################################

locals {

  fluent_bit_irsa_roles = var.fluent_bit_irsa.enabled ? {

    (var.fluent_bit_irsa.role_name) = {

      description = var.fluent_bit_irsa.description

      namespace = var.fluent_bit_irsa.namespace

      service_account = var.fluent_bit_irsa.service_account

      custom_policies = [
        var.fluent_bit_irsa.custom_policy
      ]

      path = var.fluent_bit_irsa.path

      max_session_duration = var.fluent_bit_irsa.max_session_duration

      tags = var.fluent_bit_irsa.tags

    }

  } : {}

}


#########################################################
# FLUENT BIT IAM POLICY
#########################################################

locals {

  fluent_bit_policies = {

    "${var.fluent_bit_irsa.custom_policy}" = {

      description = "Allows Fluent Bit to write logs to CloudWatch Logs."

      policy_file = "../../policies/fluent-bit-cloudwatch.json"

      path = "/"

      tags = var.fluent_bit_irsa.tags

    }

  }

}


#########################################################
# OPENTELEMETRY IRSA ROLE
#########################################################

locals {

  opentelemetry_irsa_roles = var.opentelemetry_irsa.enabled ? {

    (var.opentelemetry_irsa.role_name) = {

      description = var.opentelemetry_irsa.description

      namespace = var.opentelemetry_irsa.namespace

      service_account = var.opentelemetry_irsa.service_account

      custom_policies = [
        var.opentelemetry_irsa.custom_policy
      ]

      path = var.opentelemetry_irsa.path

      max_session_duration = var.opentelemetry_irsa.max_session_duration

      tags = var.opentelemetry_irsa.tags

    }

  } : {}

}


#########################################################
# OPENTELEMETRY IAM POLICY
#########################################################

locals {

  opentelemetry_policies = {

    (var.opentelemetry_irsa.custom_policy) = {

      description = "Allows OpenTelemetry Collector to publish traces to AWS X-Ray."

      policy_file = "../../policies/opentelemetry-xray.json"

      path = "/"

      tags = var.opentelemetry_irsa.tags

    }

  }

}



