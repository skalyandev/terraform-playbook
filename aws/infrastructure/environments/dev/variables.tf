################################################
# VPC VARIABLES
################################################
variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  type = string
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

################################################
# AZ VARIABLES
################################################

variable "availability_zones" {

  description = "Availability zones used by the infrastructure"

  type = list(string)

  default = [
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1c"
  ]
}

################################################
# SUBNET VARIABLES
################################################
variable "subnets" {

  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    subnet_type             = string
    purpose                 = string
    route_table             = string
  }))
}


#################################################
# ROUTE TABLE VARIABLES
#################################################
variable "route_tables" {

  type = map(object({
    route_type = string
    availability_zone = string
  }))
}

##################################################
# ROUTES VARIABLES
##################################################
variable "routes" {

  type = map(object({

    route_table = string

    destination = string

    target_type = string

    target_name = optional(string)

  }))
}

###################################################
# SUBNET ROUTE TABLE VARIABLES
###################################################
#variable "subnet_route_table_mapping" {

#  description = "Mapping of subnet type and AZ to route table"
#  type = map(map(string))
#}


###################################################
# SECURITY GRP VARIABLES
###################################################
variable "security_groups" {

  type = map(object({
    description = string
  }))
}

###################################################
# SECURITY GRP RULES VARIABLES
###################################################

variable "security_group_rules" {

  description = "Security Group Rules"
  type        = any

}

####################################################
# IAM ROLES
####################################################

variable "roles" {

  type = map(object({

    description          = optional(string)
    trusted_services     = optional(list(string), [])
    trusted_aws_arns     = optional(list(string), [])
    max_session_duration = optional(number, 3600)
    path                 = optional(string, "/")
    tags                 = optional(map(string), {})

  }))
}

####################################################
# IAM POLICIES
####################################################

variable "policies" {

  type = map(object({

    description = optional(string)
    policy_file = string
    path        = optional(string, "/")
    tags        = optional(map(string), {})

  }))
}
####################################################
# ROLE POLICY ATTACHMENT
####################################################
variable "attachments" {

  type = map(object({

    role             = string
    custom_policies  = optional(list(string), [])
    managed_policies = optional(list(string), [])
  }))
}



####################################################
# INSTANCE PROFILES
####################################################

variable "instance_profiles" {

  type = map(object({

    role = string
    path = optional(string, "/")
    tags = optional(map(string), {})

  }))

}

#########################################################
# AMI VARIABLES
#########################################################
variable "amis" {

  type = any

}

#########################################################
# EC2 VARIABLES
#########################################################
variable "public_instances" {
  type = any
}

variable "private_instances" {
  type = any
}



#########################################################
# EKS CLUSTERS VARIABLES
#########################################################
variable "eks_clusters" {

  type = any

}

#########################################################
# EKS NODE GRPS VARIABLES
#########################################################
variable "eks_node_groups" {

  type = any

}

#########################################################
# EKS ACCESS VARIABLES
#########################################################
variable "access_entries" {
  type = any
}


#########################################################
# IRSA ROLES
#########################################################

variable "irsa_roles" {

  description = "IRSA Roles"

  type = map(object({

    description          = optional(string)
    namespace            = string
    service_account      = string
    custom_policies      = optional(list(string), [])
    path                 = optional(string, "/")
    max_session_duration = optional(number, 3600)
    tags                 = optional(map(string), {})

  }))

}


#########################################################
# NODE AUTOSCALING
#########################################################
variable "node_autoscaling" {

  description = "Enable Kubernetes Cluster Autoscaler"
  type        = bool
  default     = false

}


#########################################################
# POD AUTOSCALING
#########################################################
variable "pod_autoscaling" {
  description = "Enable Kubernetes Pod Autoscaling"
  type        = bool
  default     = false
}


#########################################################
# EBS CSI
#########################################################

variable "ebs_csi_enabled" {
  description = "Enable AWS EBS CSI Driver"
  type        = bool
  default     = false
}


variable "ebs_csi_addon_version" {
  description = "AWS EBS CSI Driver EKS add-on version"
  type        = string
}

#########################################################
# EFS CSI
#########################################################
variable "efs_csi_enabled" {
  description = "Enable AWS EFS CSI Driver"
  type        = bool
  default     = false
}

variable "efs_csi_addon_version" {
  description = "AWS EFS CSI Driver EKS add-on version"
  type        = string
}

#########################################################
# EkS ADD-ON (Vpc-cni + CoreDns + Kube-proxy)
#########################################################
variable "eks_addons_enabled" {
  description = "Enable AWS managed EKS foundational add-ons"
  type        = bool
  default     = false
}

variable "eks_addon_versions" {
  description = "AWS managed EKS add-on versions"

  type = object({
    vpc_cni    = string
    coredns    = string
    kube_proxy = string
  })
}


#########################################################
# EBS VARIABLES
#########################################################
variable "ebs_volumes" {

  description = "EBS Volumes"
  type        = any

}

variable "volume_attachments" {

  description = "EBS Volumes"
  type        = any

}


#########################################################
# ALB TARGET GRP VARIABLES
#########################################################
variable "target_groups" {

  description = "ALB TARGET GRPS"
  type        = any

}

#########################################################
# ALB VARIABLES
#########################################################
variable "load_balancers" {

  description = "ALB"
  type        = any
}


#########################################################
# ALB LISTNERS
#########################################################

variable "listeners" {
  description = "ALB LISTNERS"
  type        = any
}

#########################################################
# TARGET GROUP ATTACHMENTS
#########################################################

variable "target_group_attachments" {

  type = map(any)

}

#########################################################
# ROUTE 53 HOSTED ZONE
#########################################################
variable "domain_name" {
  description = "Public domain name."
  type        = string
}

#########################################################
# ROUTE 53 RECORD
#########################################################
variable "route53_records" {
  description = "Route53 Alias records."

  type = map(object({
    name = string
  }))
}

#########################################################
# S3 BUCKETS
#########################################################
variable "s3_buckets" {
  description = "S3 Buckets"

  type = any

}

#########################################################
# ECR VRBL'S
#########################################################
variable "ecr_repositories" {

  type = map(object({

    image_tag_mutability = string
    scan_on_push         = bool

  }))
}


#########################################################
# SNS TOPICS
#########################################################

variable "sns_topics" {

  type = map(object({
    display_name = optional(string)
    fifo_topic   = optional(bool, false)
  }))

}


#########################################################
# SNS SUBSCRIPTIONS
#########################################################

variable "sns_subscriptions" {

  type = map(object({

    topic    = string
    protocol = string
    endpoint = string
  }))

}

#########################################################
# CLOUDWATCH LOG GROUPS
#########################################################

variable "cloudwatch_log_groups" {

  description = "CloudWatch Log Groups"
  type        = any
}


#########################################################
# CLOUDWATCH METRIC ALARMS
#########################################################
variable "metric_alarms" {

  description = "Metric Alarms"
  type        = any

}

#########################################################
# CLOUDWATCH AGENTS
#########################################################

variable "cloudwatch_agents" {

  description = "CloudWatch Agent configuration"

  type = map(object({

    config_name        = string
    ssm_parameter_name = optional(string)
    mode               = optional(string, "ec2")
    restart            = optional(bool, true)
    install_agent      = optional(bool, true)
    parameters         = optional(map(string), {})
    tags               = optional(map(string), {})
  }))
}




#########################################################
# CLOUDTRAIL
#########################################################

variable "cloudtrail_trails" {

  description = "CloudTrail trail configurations."

  type = map(object({

    name                          = optional(string)
    s3_bucket_name                = string
    s3_key_prefix                 = optional(string)
    include_global_service_events = optional(bool, true)
    is_multi_region_trail         = optional(bool, true)
    enable_log_file_validation    = optional(bool, true)
    is_organization_trail         = optional(bool, false)
    cloudwatch_log_group_arn      = optional(string)
    cloudwatch_logs_role_arn      = optional(string)
    include_management_events     = optional(bool, true)
    read_write_type               = optional(string, "All")
    tags                          = optional(map(string), {})
  }))

  default = {}

}

#########################################################
# CLOUDWATCH LOG METRIC FILTERS
#########################################################

variable "metric_filters" {

  description = "CloudWatch Log Metric Filter configurations."

  type = map(object({

    log_group_name    = string
    filter_pattern    = string
    metric_name       = string
    metric_namespace  = string
    metric_value      = optional(string, "1")
    default_value     = optional(number, 0)
    metric_dimensions = optional(map(string), {})
  }))

  default = {}

}

#########################################################
# AWS CONFIG
#########################################################

variable "aws_config" {

  description = "AWS Config configuration."

  type = object({

    name                              = optional(string, "default")
    recording_all_supported_resources = optional(bool, true)
    include_global_resource_types     = optional(bool, true)
    resource_types                    = optional(list(string), [])
    role_arn                          = optional(string)
    s3_bucket_name                    = optional(string)
    s3_key_prefix                     = optional(string)
    sns_topic_arn                     = optional(string)
    delivery_frequency                = optional(string, "TwentyFour_Hours")
    enabled                           = optional(bool, true)
    tags                              = optional(map(string), {})
  })

  default = {
    enabled = false
  }
}

#########################################################
# AWS CONFIG RULES
#########################################################

variable "config_rules" {

  description = "AWS Config rule configurations."

  type = map(object({

    name                           = optional(string)
    description                    = optional(string)
    source_identifier              = string
    maximum_execution_frequency    = optional(string)
    input_parameters               = optional(map(string), {})
    compliance_resource_types      = optional(list(string), [])
    tag_key                        = optional(string)
    tag_value                      = optional(string)
    enabled                        = optional(bool, true)
    remediation_enabled            = optional(bool, false)
    remediation_target_type        = optional(string)
    remediation_target_id          = optional(string)
    remediation_parameters         = optional(map(string), {})
    automatic_remediation_attempts = optional(number)
    retry_attempt_seconds          = optional(number)
  }))

  default = {}

}


#########################################################
# AWS CONFIG REMEDIATION
#########################################################

variable "remediations" {

  description = "AWS Config remediation configurations."

  type = map(object({

    config_rule_name = string

    target_type = optional(
      string,
      "SSM_DOCUMENT"
    )

    target_id = string

    target_version = optional(string)

    parameters = optional(
      map(object({
        static_value   = optional(list(string))
        resource_value = optional(string)
      })),
      {}
    )

    automatic = optional(
      bool,
      false
    )

    maximum_automatic_attempts = optional(
      number,
      5
    )

    retry_attempt_seconds = optional(
      number,
      60
    )

    enabled = optional(
      bool,
      true
    )

  }))

  default = {}

}


#########################################################
# AWS SECURITY HUB
#########################################################

variable "security_hub" {

  description = "AWS Security Hub configuration."

  type = object({

    enabled = optional(
      bool,
      false
    )

    enable_aws_foundational_security_best_practices = optional(
      bool,
      true
    )

    enable_cis_aws_foundations_benchmark = optional(
      bool,
      false
    )

    enable_pci_dss = optional(
      bool,
      false
    )

    auto_enable_controls = optional(
      bool,
      true
    )

    auto_enable_org_members = optional(
      bool,
      false
    )

    tags = optional(
      map(string),
      {}
    )

  })

  default = {

    enabled = false

  }

}


#########################################################
# FLUENT BIT
#########################################################
variable "fluent_bit" {

  description = "Fluent Bit configuration for EKS log collection."

  type = object({

    enabled = optional(bool, true)

    namespace = optional(
      string,
      "amazon-cloudwatch"
    )

    service_account_name = optional(
      string,
      "fluent-bit"
    )

    #####################################################
    # IRSA
    #####################################################

    irsa_role_arn = optional(
      string,
      ""
    )

    #####################################################
    # IMAGE
    #####################################################

    image_repository = optional(
      string,
      "public.ecr.aws/aws-observability/aws-for-fluent-bit"
    )

    image_tag = optional(
      string,
      "stable"
    )

    #####################################################
    # CLOUDWATCH
    #####################################################

    log_group_name = optional(
      string,
      "/aws/eks/fluent-bit"
    )

    log_stream_prefix = optional(
      string,
      "eks"
    )

    region = optional(
      string,
      "ap-south-1"
    )

    #####################################################
    # LOG COLLECTION
    #####################################################

    read_from_head = optional(
      bool,
      false
    )

    db = optional(
      string,
      "/fluent-bit/state/fluent-bit.db"
    )

    #####################################################
    # RESOURCES
    #####################################################

    cpu_request = optional(
      string,
      "100m"
    )

    memory_request = optional(
      string,
      "128Mi"
    )

    cpu_limit = optional(
      string,
      "500m"
    )

    memory_limit = optional(
      string,
      "512Mi"
    )

    #####################################################
    # TOLERATIONS
    #####################################################

    tolerate_all = optional(
      bool,
      true
    )

    #####################################################
    # TAGS
    #####################################################

    tags = optional(
      map(string),
      {}
    )

  })

  default = {}

}


#########################################################
# OPENTELEMETRY
#########################################################

variable "opentelemetry" {

  description = "OpenTelemetry Collector configuration for EKS."

  type = object({

    #####################################################
    # ENABLE / DISABLE
    #####################################################

    enabled = optional(
      bool,
      false
    )

    #####################################################
    # KUBERNETES
    #####################################################

    namespace = optional(
      string,
      "opentelemetry"
    )

    service_account_name = optional(
      string,
      "opentelemetry-collector"
    )

    #####################################################
    # DEPLOYMENT
    #####################################################

    mode = optional(
      string,
      "deployment"
    )

    replicas = optional(
      number,
      1
    )

    #####################################################
    # IMAGE
    #####################################################

    image_repository = optional(
      string,
      "otel/opentelemetry-collector-contrib"
    )

    image_tag = optional(
      string,
      "0.133.0"
    )

    #####################################################
    # OTLP
    #####################################################

    otlp_grpc_port = optional(
      number,
      4317
    )

    otlp_http_port = optional(
      number,
      4318
    )

    #####################################################
    # HEALTH CHECK
    #####################################################

    health_check_port = optional(
      number,
      13133
    )

    #####################################################
    # PROMETHEUS
    #####################################################

    prometheus_enabled = optional(
      bool,
      false
    )

    prometheus_port = optional(
      number,
      8889
    )

    #####################################################
    # AWS X-RAY
    #####################################################

    aws_xray_enabled = optional(
      bool,
      false
    )

    #####################################################
    # CLOUDWATCH
    #####################################################

    cloudwatch_enabled = optional(
      bool,
      false
    )

    #####################################################
    # OTLP EXPORTER
    #####################################################

    otlp_exporter_enabled = optional(
      bool,
      false
    )

    otlp_exporter_endpoint = optional(
      string,
      ""
    )

    #####################################################
    # RESOURCES
    #####################################################

    cpu_request = optional(
      string,
      "100m"
    )

    memory_request = optional(
      string,
      "128Mi"
    )

    cpu_limit = optional(
      string,
      "500m"
    )

    memory_limit = optional(
      string,
      "512Mi"
    )

    #####################################################
    # ENVIRONMENT
    #####################################################

    environment = optional(
      string,
      "dev"
    )

    #####################################################
    # TAGS
    #####################################################

    tags = optional(
      map(string),
      {}
    )

  })

  default = {}

}


#########################################################
# FLUENT BIT IRSA
#########################################################

variable "fluent_bit_irsa" {

  description = "IRSA configuration for Fluent Bit."

  type = object({

    enabled = optional(bool, true)

    role_name = optional(
      string,
      "dev-fluent-bit"
    )

    namespace = optional(
      string,
      "amazon-cloudwatch"
    )

    service_account = optional(
      string,
      "fluent-bit"
    )

    description = optional(
      string,
      "IRSA role for Fluent Bit CloudWatch logging."
    )

    custom_policy = optional(
      string,
      "fluent-bit-cloudwatch"
    )

    path = optional(
      string,
      "/"
    )

    max_session_duration = optional(
      number,
      3600
    )

    tags = optional(
      map(string),
      {}
    )

  })

  default = {}

}

#########################################################
# OPENTELEMETRY IRSA
#########################################################

variable "opentelemetry_irsa" {

  description = "IRSA configuration for OpenTelemetry Collector."

  type = object({

    enabled = optional(
      bool,
      true
    )

    role_name = optional(
      string,
      "dev-opentelemetry"
    )

    namespace = optional(
      string,
      "opentelemetry"
    )

    service_account = optional(
      string,
      "opentelemetry"
    )

    description = optional(
      string,
      "IRSA role for OpenTelemetry Collector."
    )

    custom_policy = optional(
      string,
      "opentelemetry-xray"
    )

    path = optional(
      string,
      "/"
    )

    max_session_duration = optional(
      number,
      3600
    )

    tags = optional(
      map(string),
      {}
    )

  })

  default = {}

}







