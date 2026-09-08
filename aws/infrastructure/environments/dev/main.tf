#####################################################
# VPC MODULE
#####################################################
module "vpc" {

  source = "../../modules/networking/vpc"

  name                 = "${local.name_prefix}-vpc"
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags                 = local.common_tags

}

######################################################
# SUBNET MODULE
######################################################

module "subnets" {

  source = "../../modules/networking/subnet"

  vpc_id  = module.vpc.vpc_id
  subnets = var.subnets
  tags    = local.common_tags

}

#######################################################
# IGW MODULE
#######################################################
module "igw" {

  source = "../../modules/networking/internet-gateway"

  name   = "${local.name_prefix}-igw"
  vpc_id = module.vpc.vpc_id
  tags   = local.common_tags

}

#########################################################
# ELASTIC-IP MODULE
#########################################################
module "elastic_ip" {

  source = "../../modules/networking/elastic-ip"

  elastic_ips = {

    nat-a = {
      name = "${local.name_prefix}-nat-eip-a"
    }
    nat-b = {
      name = "${local.name_prefix}-nat-eip-b"
    }
    nat-c = {
      name = "${local.name_prefix}-nat-eip-c"
    }
  }

  tags = local.common_tags
}

###########################################################
# NAT GW MODULE
###########################################################
module "nat_gateway" {

  source = "../../modules/networking/nat-gateway"

  nat_gateways = {

    nat-a = {
      allocation_id = module.elastic_ip.allocation_ids["nat-a"]
      subnet_id     = module.subnets.subnet_ids["bastion-public-sbnt-ap-suth-a"]
    }

    nat-b = {
      allocation_id = module.elastic_ip.allocation_ids["nat-b"]
      subnet_id     = module.subnets.subnet_ids["bastion-public-sbnt-ap-suth-b"]
    }

  }

  tags = local.common_tags
}

############################################################
# ROUTE TABLES MODULE
############################################################

module "route_tables" {

  source = "../../modules/networking/route-table"

  vpc_id       = module.vpc.vpc_id
  route_tables = var.route_tables
  tags         = local.common_tags

}

########################################################
# ROUTE TABLE ASSOCIATIONS
########################################################
module "route_table_associations" {

  source = "../../modules/networking/route-table-association"

  subnet_details = module.subnets.subnet_details
  route_table_ids = module.route_tables.route_table_ids
  tags = local.common_tags
}

########################################################
# ROUTES
########################################################

module "routes" {

  source = "../../modules/networking/routes"

  routes              = var.routes
  route_table_ids     = module.route_tables.route_table_ids
  internet_gateway_id = module.igw.internet_gateway_id
  nat_gateway_ids     = module.nat_gateway.nat_gateway_ids
  tags                = local.common_tags
}

########################################################
# SECURITY GROUPS
########################################################

module "security_groups" {

  source = "../../modules/security/security-group"

  vpc_id          = module.vpc.vpc_id
  security_groups = var.security_groups
  tags            = local.common_tags

}

#######################################################
# SECURITY GRP RULES
#######################################################
module "security_group_rules" {

  source = "../../modules/security/security-group-rule"

  security_group_ids = module.security_groups.security_group_ids

  security_group_rules = var.security_group_rules

}


#########################################################
# IAM ROLE
#########################################################
module "iam_roles" {

  source = "../../modules/iam/role"
  roles  = var.roles
  tags   = local.common_tags
}


#########################################################
# IAM POLICIES
#########################################################

#module "iam_policies" {

#  source = "../../modules/iam/policy"

#  policies = var.policies
#  tags     = local.common_tags

#}

module "iam_policies" {

  source = "../../modules/iam/policy"

  policies = merge(
    var.policies,
    local.fluent_bit_policies,
    local.opentelemetry_policies
  )

  tags = local.common_tags

}


#########################################################
# ROLE POLICY ATTACHMENTS
#########################################################

module "role_policy_attachments" {

  source = "../../modules/iam/role-policy-attachment"

  attachments = var.attachments
  role_names  = module.iam_roles.role_names
  policy_arns = module.iam_policies.policy_arns

}

#########################################################
# INSTANCE PROFILE
#########################################################

module "instance_profiles" {

  source = "../../modules/iam/instance-profile"

  instance_profiles = var.instance_profiles
  role_names        = module.iam_roles.role_names
  tags              = local.common_tags
}

#########################################################
# AMI MODULE
#########################################################

module "amis" {

  source = "../../modules/compute/ami"

  amis = var.amis

}

#########################################################
# PUBLIC EC2 
#########################################################

module "public_ec2" {

  source = "../../modules/compute/ec2"

  instances              = var.public_instances
  ami_ids                = module.amis.ami_ids
  subnet_ids             = module.subnets.subnet_lookup
  security_group_ids     = module.security_groups.security_group_ids
  instance_profile_names = module.instance_profiles.instance_profile_names
  tags                   = local.common_tags

}


#########################################################
# PRIVATE EC2
#########################################################

module "private_ec2" {

  source = "../../modules/compute/ec2"

  instances              = var.private_instances
  ami_ids                = module.amis.ami_ids
  subnet_ids             = module.subnets.subnet_lookup
  security_group_ids     = module.security_groups.security_group_ids
  instance_profile_names = module.instance_profiles.instance_profile_names
  tags                   = local.common_tags

}


#########################################################
# EKS CLUSTER
#########################################################

module "eks_cluster" {

  source = "../../modules/containers/eks-cluster"

  eks_clusters       = var.eks_clusters
  role_arns          = module.iam_roles.role_arns
  private_subnet_ids = module.subnets.private_subnet_ids["eks"]
  security_group_ids = module.security_groups.security_group_ids
  tags               = local.common_tags

}


#########################################################
# EKS NODE GROUPS
#########################################################

module "eks_node_groups" {

  source = "../../modules/containers/eks-node-group"

  eks_node_groups    = var.eks_node_groups
  cluster_names      = module.eks_cluster.cluster_ids
  role_arns          = module.iam_roles.role_arns
  private_subnet_ids = module.subnets.private_subnet_ids["eks"]
  tags               = local.common_tags

}

#########################################################
# EKS ACCESS
#########################################################

module "eks_access" {

  source         = "../../modules/containers/eks-access"
  cluster_names  = module.eks_cluster.cluster_names
  access_entries = var.access_entries

}

#########################################################
# OIDC PROVIDER
#########################################################

module "oidc_provider" {

  source               = "../../modules/iam/oidc-provider"
  cluster_oidc_issuers = module.eks_cluster.cluster_oidc_issuers
  tags                 = local.common_tags
}

#########################################################
# IRSA
#########################################################
module "irsa" {

  source = "../../modules/iam/irsa"

  irsa_roles = merge(
    var.irsa_roles,
    local.fluent_bit_irsa_roles,
    local.opentelemetry_irsa_roles
  )

  policy_arns       = module.iam_policies.policy_arns
  oidc_provider_arn = module.oidc_provider.oidc_provider_arns["boutique-dev"]
  oidc_provider_url = module.oidc_provider.oidc_provider_urls["boutique-dev"]
  tags              = local.common_tags
}

#########################################################
# CLUSTER AUTOSCALER
#########################################################

module "cluster_autoscaler" {

  count  = var.node_autoscaling ? 1 : 0
  source = "../../modules/containers/cluster-autoscaler"

  cluster_autoscaler = {
    enabled              = var.node_autoscaling
    cluster_name         = module.eks_cluster.cluster_names["boutique-dev"]
    namespace            = "kube-system"
    service_account_name = "cluster-autoscaler"
  }

  oidc_provider_arn = module.oidc_provider.oidc_provider_arns["boutique-dev"]
  oidc_provider_url = module.oidc_provider.oidc_provider_urls["boutique-dev"]
  iam_policy_path   = "${path.root}/../../policies/cluster-autoscaler.json"

  helm = {
    chart_version = "9.59.0"
  }

  tags = local.common_tags
}

##########################################
# EKS POD AUTO SCALER
##########################################

module "pod_autoscaler" {

  count = var.pod_autoscaling ? 1 : 0

  source = "../../modules/containers/pod-autoscaler"

  pod_autoscaling = {
    enabled              = var.pod_autoscaling
    namespace            = "kube-system"
    service_account_name = "metrics-server"
  }

  helm = {
    chart_version = "3.13.0"
  }

  tags = local.common_tags
}

#########################################################
# AWS LOAD BALANCER CONTROLLER
#########################################################
module "aws_load_balancer_controller" {

  source = "../../modules/containers/aws-load-balancer-controller"

  cluster_name      = module.eks_cluster.cluster_names["boutique-dev"]
  region            = var.aws_region
  vpc_id            = module.vpc.vpc_id
  oidc_provider_url = module.eks_cluster.cluster_oidc_issuers["boutique-dev"]
  oidc_provider_arn = module.eks_cluster.cluster_oidc_provider_arns["boutique-dev"]
}

#########################################################
# EXTERNAL DNS
#########################################################
module "external_dns" {


  source = "../../modules/containers/external-dns"

  cluster_name      = module.eks_cluster.cluster_names["boutique-dev"]
  region            = var.aws_region
  oidc_provider_url = module.eks_cluster.cluster_oidc_issuers["boutique-dev"]
  oidc_provider_arn = module.eks_cluster.cluster_oidc_provider_arns["boutique-dev"]
  domain_name       = "cloud-devops-lab.xyz"
  zone_id           = module.route53_hosted_zone.zone_id
  tags              = local.common_tags

}

#########################################################
# EBS CSI DRIVER
#########################################################
module "ebs_csi" {

  count = var.ebs_csi_enabled ? 1 : 0

  source = "../../modules/containers/ebs-csi"

  ebs_csi = {
    enabled       = var.ebs_csi_enabled
    cluster       = "boutique-dev"
    addon_version = var.ebs_csi_addon_version
  }

  cluster_names      = module.eks_cluster.cluster_names
  oidc_provider_arns = module.oidc_provider.oidc_provider_arns
  oidc_provider_urls = module.oidc_provider.oidc_provider_urls
  tags               = local.common_tags
}

#########################################################
# EFS CSI DRIVER
#########################################################
module "efs_csi" {
  count = var.efs_csi_enabled ? 1 : 0

  source = "../../modules/containers/efs-csi"

  efs_csi = {
    enabled                   = var.efs_csi_enabled
    cluster                   = "boutique-dev"
    addon_version             = var.efs_csi_addon_version
    service_account_role_name = "efs-csi-controller"
  }

  cluster_names      = module.eks_cluster.cluster_names
  oidc_provider_arns = module.oidc_provider.oidc_provider_arns
  oidc_provider_urls = module.oidc_provider.oidc_provider_urls

  tags = local.common_tags
}

#########################################################
# EKS AddOns
#########################################################
module "eks_addons" {
  count  = var.eks_addons_enabled ? 1 : 0
  source = "../../modules/containers/eks-addons"

  eks_addons = {
    vpc_cni = {
      cluster_name  = module.eks_cluster.cluster_names["boutique-dev"]
      addon_name    = "vpc-cni"
      addon_version = var.eks_addon_versions.vpc_cni
    }

    coredns = {
      cluster_name  = module.eks_cluster.cluster_names["boutique-dev"]
      addon_name    = "coredns"
      addon_version = var.eks_addon_versions.coredns
    }

    kube_proxy = {
      cluster_name  = module.eks_cluster.cluster_names["boutique-dev"]
      addon_name    = "kube-proxy"
      addon_version = var.eks_addon_versions.kube_proxy
    }
  }

  tags = local.common_tags
}


########################################################################################################
#                                        EBS VOLUMLES                                                  #
########################################################################################################
module "ebs" {

  source = "../../modules/storage/ebs"

  ebs_volumes = var.ebs_volumes
  tags        = local.common_tags

}

#########################################################
# EBS VOULME ATTACTMENTS
#########################################################

module "volume_attachments" {

  source = "../../modules/compute/volume-attachment"

  volume_attachments = var.volume_attachments
  instance_ids       = local.ec2_instance_ids
  volume_ids         = module.ebs.ebs_volume_ids

}


########################################################################################################
#                                                ALB                                                   #
########################################################################################################

#########################################################
# TARGET GRPS
#########################################################
module "target_groups" {

  source = "../../modules/networking/load-balancer/target-group"

  target_groups = var.target_groups
  vpc_id        = module.vpc.vpc_id
  tags          = local.common_tags

}

#########################################################
# ALB 
#########################################################
module "load_balancers" {

  source = "../../modules/networking/load-balancer/alb"

  load_balancers     = var.load_balancers
  subnet_ids         = module.subnets.subnet_lookup
  security_group_ids = module.security_groups.security_group_ids
  tags               = local.common_tags

}


#########################################################
# LOAD BALANCER LISTENERS
#########################################################
module "listeners" {

  source = "../../modules/networking/load-balancer/listener"

  listeners          = local.listeners
  load_balancer_arns = module.load_balancers.alb_arns
  target_group_arns  = module.target_groups.target_group_arns

  #certificate_arn = module.acm.certificate_arn
}



#########################################################
# TARGET GROUP ATTACHMENTS
#########################################################

module "target_group_attachments" {

  source = "../../modules/networking/load-balancer/target-group-attachment"

  target_group_attachments = var.target_group_attachments
  target_group_arns        = module.target_groups.target_group_arns
  instance_ids             = local.ec2_instance_ids

}


#########################################################
# ROUTE 53 HOSTED ZONE
#########################################################
module "route53_hosted_zone" {
  source = "../../modules/networking/route53/hosted-zone"

  domain_name = var.domain_name

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-public-hosted-zone"
    }
  )
}

#########################################################
# ROUTE 53 RECORD
#########################################################
module "route53_record" {

  source = "../../modules/networking/route53/record"

  zone_id = module.route53_hosted_zone.zone_id
  records = local.route53_records

}

#########################################################
# ACM
#########################################################
module "acm" {

  source = "../../modules/networking/acm"

  domain_name = "*.cloud-devops-lab.xyz"
  zone_id     = module.route53_hosted_zone.zone_id
  tags        = local.common_tags
}

#########################################################
# S3 BUCKETS
#########################################################

module "s3_buckets" {

  source = "../../modules/storage/s3"

  buckets = var.s3_buckets
  tags    = local.common_tags

}


#########################################################
# AWS CONFIG S3 BUCKET POLICY
#########################################################
#########################################################
# AWS CONFIG S3 BUCKET POLICY
#########################################################

data "aws_iam_policy_document" "aws_config_s3" {

  #######################################################
  # Bucket Permissions
  #######################################################

  statement {

    sid    = "AWSConfigBucketPermissionsCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
      "s3:ListBucket"
    ]

    resources = [
      module.s3_buckets.bucket_arns["centralized-logs"]
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"

      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
  }

  #######################################################
  # Config Object Delivery
  #######################################################

  statement {

    sid    = "AWSConfigBucketDelivery"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${module.s3_buckets.bucket_arns["centralized-logs"]}/AWSLogs/${data.aws_caller_identity.current.account_id}/Config/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"

      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
  }
}

#########################################################
# AWS CONFIG S3 BUCKET POLICY
#########################################################

resource "aws_s3_bucket_policy" "aws_config" {

  bucket = module.s3_buckets.bucket_ids["centralized-logs"]

  policy = data.aws_iam_policy_document.aws_config_s3.json

  depends_on = [
    module.s3_buckets
  ]
}



#########################################################
# ECR MODULE
#########################################################
module "ecr" {

  source = "../../modules/ecr"

  ecr_repositories = var.ecr_repositories
  tags             = local.common_tags
}

########################################################################################################
#                                       OBSERVABILITY                                                  #
########################################################################################################


#########################################################
# CLOUDWATCH AGENT
#########################################################

module "cloudwatch_agents" {

  source = "../../modules/observability/logs/cloudwatch-agent"

  cloudwatch_agents = local.cloudwatch_agents
  tags              = local.common_tags
}

#########################################################
# CLOUDWATCH LOG GROUPS
#########################################################

module "cloudwatch_log_groups" {

  source = "../../modules/observability/logs/cloudwatch-log-group"

  cloudwatch_log_groups = var.cloudwatch_log_groups
  tags                  = local.common_tags

}

#########################################################
# CLOUDWATCH DASHBOARDS
#########################################################

module "cloudwatch_dashboards" {

  source = "../../modules/observability/metrics/cloudwatch-dashboard"

  region     = var.aws_region
  dashboards = local.cloudwatch_dashboards

}

#########################################################
# CLOUDWATCH METRIC ALARMS
#########################################################
module "cloudwatch_metric_alarms" {

  source = "../../modules/observability/metrics/cloudwatch-metric-alarm"

  metric_alarms  = local.cloudwatch_metric_alarms
  sns_topic_arns = module.sns_topics.sns_topic_arns
  tags           = local.common_tags

}

#########################################################
# LOG SUBSCRIPTION
#########################################################
#module "log_subscription" {

#  source = "../../modules/observability/logs/log-subscription"

#  subscriptions = local.log_subscriptions

#}



#########################################################
# SNS TOPICS
#########################################################
module "sns_topics" {

  source = "../../modules/observability/notifications/sns-topic"

  topics = var.sns_topics
  tags   = local.common_tags
}

#########################################################
# SNS SUBSCRIPTIONS
#########################################################

module "sns_subscriptions" {

  source = "../../modules/observability/notifications/sns-subscription"

  topic_arns    = module.sns_topics.sns_topic_arns
  subscriptions = var.sns_subscriptions

}


#########################################################
# CLOUDWATCH COMPOSITE ALARMS
#########################################################

module "cloudwatch_composite_alarms" {

  source = "../../modules/observability/metrics/cloudwatch-composite-alarm"

  composite_alarms = local.cloudwatch_composite_alarms
  sns_topic_arns   = module.sns_topics.sns_topic_arns
  tags             = local.common_tags

  depends_on = [
    module.cloudwatch_metric_alarms
  ]

}


#########################################################
# VPC FLOW LOGS
#########################################################

module "vpc_flow_logs" {

  source = "../../modules/observability/logs/vpc-flow-logs"

  vpc_flow_logs = local.vpc_flow_logs
  tags          = local.common_tags

}


#########################################################
# CLOUDWATCH LOG SUBSCRIPTIONS
#########################################################

##Enable this module after the desitnation module is developed 
## (Kinesis / Firehose / Lambda ) is implemented.

#module "log_subscriptions" {

#  source = "../../modules/observability/logs/log-subscription"

#  log_subscriptions = local.log_subscriptions
#  tags = local.common_tags

#}


#########################################################
# KINESIS DATA FIREHOSE
#########################################################
#module "kinesis_firehose" {

#  source = "../../modules/observability/logs/kinesis-firehose"

#  firehose_streams = local.firehose_streams
#  iam_role_arns = module.iam_roles.role_arns
#  tags = local.common_tags

#}

#########################################################
# CLOUDTRAIL
#########################################################
data "aws_iam_policy_document" "cloudtrail_s3" {

  statement {
    sid    = "AWSCloudTrailBucketPermissionsCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
      "s3:ListBucket"
    ]

    resources = [
      module.s3_buckets.bucket_arns["cloudtrail-logs"]
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }

  statement {
    sid    = "AWSCloudTrailBucketDelivery"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${module.s3_buckets.bucket_arns["cloudtrail-logs"]}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = module.s3_buckets.bucket_ids["cloudtrail-logs"]

  policy = data.aws_iam_policy_document.cloudtrail_s3.json
}

module "cloudtrail" {

  source = "../../modules/observability/security/cloudtrail"

  trails = var.cloudtrail_trails
  tags   = local.common_tags

  depends_on = [
    aws_s3_bucket_policy.cloudtrail
  ]

}


#########################################################
# CLOUDWATCH LOG METRIC FILTERS
#########################################################

module "cloudwatch_log_metric_filters" {

  source = "../../modules/observability/security/cloudwatch-log-metric-filter"

  metric_filters = var.metric_filters

}


#########################################################
# AWS CONFIG
#########################################################

module "aws_config" {

  source = "../../modules/observability/security/aws-config"

  config = local.aws_config
  tags   = local.common_tags

  depends_on = [
    aws_s3_bucket_policy.aws_config
  ]

}


#########################################################
# AWS CONFIG RULES
#########################################################

module "aws_config_rules" {

  source = "../../modules/observability/security/aws-config-rule"

  config_rules = var.config_rules

}


#########################################################
# AWS CONFIG REMEDIATION
#########################################################

module "aws_config_remediation" {

  source = "../../modules/observability/security/aws-config-remediation"

  remediations = local.aws_config_remediations

}


#########################################################
# AWS SECURITY HUB
#########################################################

module "security_hub" {

  source       = "../../modules/observability/security/security-hub"
  security_hub = local.security_hub

}


#########################################################
# FLUENT BIT
#########################################################

#module "fluent_bit" {

#  source = "../../modules/observability/logs/fluent-bit"

#  fluent_bit = local.fluent_bit

#}


#########################################################
# FLUENT BIT
#########################################################

module "fluent_bit" {

  source = "../../modules/observability/logs/fluent-bit"

  fluent_bit = merge(
    local.fluent_bit,
    {
      irsa_role_arn = module.irsa.role_arns["dev-fluent-bit"]
    }
  )

}


#########################################################
# OPENTELEMETRY
#########################################################

module "opentelemetry" {

  source = "../../modules/observability/traces/opentelemetry"

  opentelemetry = merge(
    local.opentelemetry,
    {
      irsa_role_arn = module.irsa.role_arns["dev-opentelemetry"]
    }
  )

}






