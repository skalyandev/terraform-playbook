#########################################
# VPC O/P's
#########################################
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "VPC ARN"
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "VPC CIDR"
  value       = module.vpc.vpc_cidr_block
}

output "default_route_table_id" {
  value = module.vpc.default_route_table_id
}

output "default_network_acl_id" {
  value = module.vpc.default_network_acl_id
}

output "default_security_group_id" {
  value = module.vpc.default_security_group_id
}

#####################################################
#  SUBNETS O/P's
#####################################################
output "subnet_ids" {
  value = module.subnets.subnet_ids
}

output "subnet_details" {
  value = module.subnets.subnet_details
}

output "subnet_lookup" {
  value = module.subnets.subnet_lookup
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

#output "subnet_ids_by_type" {
#  value = module.subnets.subnet_ids_by_type
#}

#output "subnet_route_tables" {
#  value = module.subnets.subnet_route_tables
#}

#output "subnet_lookup" {
#  value = module.subnets.subnet_lookup
#}



#####################################################
# IGW O/P's
#####################################################
output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = module.igw.internet_gateway_id
}

output "internet_gateway_arn" {
  description = "Internet Gateway ARN"
  value       = module.igw.internet_gateway_arn
}

#####################################################
# ELASTIC-IP O/P's
#####################################################
output "allocation_ids" {
  description = "Elastic IP allocation IDs keyed by NAT name"

  value = module.elastic_ip.allocation_ids
}

output "elastic_public_ips" {
  description = "Elastic IP public addresses keyed by NAT name"

  value = module.elastic_ip.elastic_public_ips
}


#####################################################
# NAT GW O/P's
#####################################################
output "nat_gateway_ids" {
  value = module.nat_gateway.nat_gateway_ids
}

output "nat_gateway_public_ips" {
  value = module.nat_gateway.nat_gateway_public_ips
}

#####################################################
# ROUTE TABLE O/P's
#####################################################
output "route_table_ids" {
  value = module.route_tables.route_table_ids
}

######################################################
# ROUTES O/P's
######################################################
output "association_subnets_ids" {
  value = module.route_table_associations.association_ids
}

######################################################
# ROUTES O/P's
######################################################
output "route_ids" {
  value = module.routes.route_ids
}

######################################################
# SECURITY GRPS O/P's
######################################################
output "security_group_ids" {
  value = module.security_groups.security_group_ids
}

output "security_group_arns" {
  value = module.security_groups.security_group_arns
}

output "security_group_names" {
  value = module.security_groups.security_group_names
}

output "security_groups" {
  value = module.security_groups.security_groups
}


#######################################################
# IAM ROLE O/P's 
#######################################################
output "role_ids" {
  value = module.iam_roles.role_ids
}

output "role_arns" {
  value = module.iam_roles.role_arns
}

output "role_names" {
  value = module.iam_roles.role_names
}

#######################################################
# IAM ROLE POLICY O/P's
#######################################################
output "policy_arns" {
  value = module.iam_policies.policy_arns
}

output "policy_names" {
  value = module.iam_policies.policy_names
}

output "policy_ids" {
  value = module.iam_policies.policy_ids
}

#######################################################
# IAM ROLE POLICY ATTACHMENT O/P's
#######################################################
output "custom_policy_attachments" {
  value = module.role_policy_attachments.custom_policy_attachments
}

output "managed_policy_attachments" {
  value = module.role_policy_attachments.managed_policy_attachments
}

#######################################################
# IAM ROLE INSTANCE PROFILE O/P's
#######################################################
output "instance_profile_arns" {
  value = module.instance_profiles.instance_profile_arns
}

output "instance_profile_names" {
  value = module.instance_profiles.instance_profile_names
}

#######################################################
# EC2 AMI O/P's
#######################################################
output "ami_ids" {
  value = module.amis.ami_ids
}

output "ami_names" {
  value = module.amis.ami_names
}

output "ami_owners" {
  value = module.amis.ami_owners
}

output "amis" {
  value = module.amis.amis
}

#######################################################
# PUBLIC EC2 OUTPUTS
#######################################################

output "public_ec2_instance_ids" {
  value = module.public_ec2.instance_ids
}

output "public_ec2_instance_arns" {
  value = module.public_ec2.instance_arns
}

output "public_ec2_private_ips" {
  value = module.public_ec2.private_ips
}

output "public_ec2_public_ips" {
  value = module.public_ec2.public_ips
}

output "public_ec2_availability_zones" {
  value = module.public_ec2.availability_zones
}

output "public_ec2_instance_states" {
  value = module.public_ec2.instance_states
}

output "public_ec2_instances" {
  value = module.public_ec2.instances
}

#######################################################
# PRIVATE EC2 OUTPUTS
#######################################################

output "private_ec2_instance_ids" {
  value = module.private_ec2.instance_ids
}

output "private_ec2_instance_arns" {
  value = module.private_ec2.instance_arns
}

output "private_ec2_private_ips" {
  value = module.private_ec2.private_ips
}

output "private_ec2_public_ips" {
  value = module.private_ec2.public_ips
}

output "private_ec2_availability_zones" {
  value = module.private_ec2.availability_zones
}

output "private_ec2_instance_states" {
  value = module.private_ec2.instance_states
}

output "private_ec2_instances" {
  value = module.private_ec2.instances
}

output "ec2_instance_ids" {

  value = merge(
    module.public_ec2.instance_ids,
    module.private_ec2.instance_ids
  )

}


#######################################################
# EBS O/P's
#######################################################
output "ebs_volume_ids" {
  value = module.ebs.ebs_volume_ids
}

output "ebs_volume_arns" {
  value = module.ebs.ebs_volume_arns
}

output "ebs_volume_azs" {
  value = module.ebs.ebs_volume_azs
}

#######################################################
# EBS VOLUME ATTACHMENT O/P's
#######################################################
output "volume_attachment_ids" {
  value = module.volume_attachments.volume_attachment_ids
}


#######################################################
# EKS O/P's
#######################################################
output "eks_cluster_ids" {
  value = module.eks_cluster.cluster_ids
}

output "eks_cluster_arns" {
  value = module.eks_cluster.cluster_arns
}

output "eks_cluster_endpoints" {
  value = module.eks_cluster.cluster_endpoints
}

output "eks_cluster_certificate_authorities" {
  value = module.eks_cluster.cluster_certificate_authorities
}

output "eks_cluster_versions" {
  value = module.eks_cluster.cluster_versions
}

output "eks_cluster_names" {
  value = module.eks_cluster.cluster_names
}

output "eks_cluster_oidc_issuers" {
  value = module.eks_cluster.cluster_oidc_issuers

}

output "cluster_oidc_provider_arns" {
  value = module.eks_cluster.cluster_oidc_provider_arns

}


output "eks_access_entries" {
  value = module.eks_access.access_entries
}

output "eks_oidc_provider_arns" {
  value = module.oidc_provider.oidc_provider_arns

}

output "eks_oidc_provider_urls" {
  value = module.oidc_provider.oidc_provider_urls
}


output "helm_release_name" {
  value = module.aws_load_balancer_controller.helm_release_name
}


output "namespace" {
  value = module.aws_load_balancer_controller.namespace
}



#########################################################
# IRSA ROLE ARNS O/P's
#########################################################
output "irsa_role_ids" {
  value = module.irsa.role_ids
}

output "irsa_role_arns" {
  value = module.irsa.role_arns
}

output "irsa_role_names" {
  value = module.irsa.role_names
}

#######################################################
# EKS AUTOSCALER O/P's
#######################################################
output "eks_autoscaler_iam_role_arn" {
  value = var.node_autoscaling ? module.cluster_autoscaler[0].eks_autoscaler_iam_role_arn : null
}

output "eks_autoscaler_iam_role_name" {
  value = var.node_autoscaling ? module.cluster_autoscaler[0].eks_autoscaler_iam_role_name : null
}

output "eks_autoscaler_iam_policy_arn" {
  value = var.node_autoscaling ? module.cluster_autoscaler[0].eks_autoscaler_iam_policy_arn : null
}

output "eks_autoscaler_service_account_name" {
  value = var.node_autoscaling ? module.cluster_autoscaler[0].eks_autoscaler_service_account_name : null
}

output "eks_autoscaler_helm_release_name" {
  value = var.node_autoscaling ? module.cluster_autoscaler[0].eks_autoscaler_helm_release_name : null
}

output "eks_autoscaler_helm_release_status" {
  value = var.node_autoscaling ? module.cluster_autoscaler[0].eks_autoscaler_helm_release_status : null
}


#######################################################
# POD AUTOSCALER OUTPUTS
#######################################################

output "pod_autoscaler_helm_release_name" {
  value = var.pod_autoscaling ? module.pod_autoscaler[0].pod_autoscaler_helm_release_name : null
}

output "pod_autoscaler_helm_release_status" {
  value = var.pod_autoscaling ? module.pod_autoscaler[0].pod_autoscaler_helm_release_status : null
}

output "pod_autoscaler_namespace" {
  value = var.pod_autoscaling ? module.pod_autoscaler[0].pod_autoscaler_namespace : null
}

output "pod_autoscaler_service_account_name" {
  value = var.pod_autoscaling ? module.pod_autoscaler[0].pod_autoscaler_service_account_name : null
}


#######################################################
# EBS CSI OUTPUTS
#######################################################
output "ebs_csi_addon_name" {
  value = var.ebs_csi_enabled ? module.ebs_csi[0].ebs_csi_addon_name : null
}

output "ebs_csi_addon_version" {
  value = var.ebs_csi_enabled ? module.ebs_csi[0].ebs_csi_addon_version : null
}

output "ebs_csi_iam_role_arn" {
  value = var.ebs_csi_enabled ? module.ebs_csi[0].ebs_csi_iam_role_arn : null
}

output "ebs_csi_iam_role_name" {
  value = var.ebs_csi_enabled ? module.ebs_csi[0].ebs_csi_iam_role_name : null
}

output "ebs_csi_iam_policy_arn" {
  value = var.ebs_csi_enabled ? module.ebs_csi[0].ebs_csi_iam_policy_arn : null
}

#######################################################
# EFS CSI OUTPUTS
#######################################################
output "efs_csi_addon_name" {
  value = var.efs_csi_enabled ? module.efs_csi[0].efs_csi_addon_name : null
}

output "efs_csi_addon_version" {
  value = var.efs_csi_enabled ? module.efs_csi[0].efs_csi_addon_version : null
}

output "efs_csi_iam_role_arn" {
  value = var.efs_csi_enabled ? module.efs_csi[0].efs_csi_iam_role_arn : null
}

output "efs_csi_iam_role_name" {
  value = var.efs_csi_enabled ? module.efs_csi[0].efs_csi_iam_role_name : null
}

output "efs_csi_iam_policy_arn" {
  value = var.efs_csi_enabled ? module.efs_csi[0].efs_csi_iam_policy_arn : null
}

# ============================================================
# EKS Foundational Add-ons
# ============================================================

output "eks_addon_names" {
  description = "EKS managed add-on names"

  value = var.eks_addons_enabled ? module.eks_addons[0].addon_names : null
}

output "eks_addon_versions" {
  description = "EKS managed add-on versions"

  value = var.eks_addons_enabled ? module.eks_addons[0].addon_versions : null
}

output "eks_addon_arns" {
  description = "EKS managed add-on ARNs"

  value = var.eks_addons_enabled ? module.eks_addons[0].addon_arns : null
}



#########################################################
# ALB  TARGET GRP O/P's
#########################################################
output "target_group_ids" {
  value = module.target_groups.target_group_ids
}

output "target_group_arns" {
  value = module.target_groups.target_group_arns
}

output "target_group_names" {
  value = module.target_groups.target_group_names
}

output "target_group_arn_suffix" {
  value = module.target_groups.target_group_arn_suffix
}

#########################################################
# ALB O/P's
#########################################################
output "alb_ids" {
  value = module.load_balancers.alb_ids
}

output "alb_arns" {
  value = module.load_balancers.alb_arns
}

output "alb_dns_names" {
  value = module.load_balancers.alb_dns_names
}

output "alb_zone_ids" {
  value = module.load_balancers.alb_zone_ids
}

output "alb_arn_suffix" {
  value = module.load_balancers.alb_arn_suffix
}


#########################################################
# ECR O/P's
#########################################################
output "repository_urls" {
  value = module.ecr.repository_urls
}

output "repository_arns" {
  value = module.ecr.repository_arns
}

output "repository_names" {
  value = module.ecr.repository_names
}


#########################################################
# ALB LISTENERS O/P's
#########################################################
output "listener_ids" {
  value = module.listeners.listener_ids
}

output "listener_arns" {
  value = module.listeners.listener_arns
}

#########################################################
# TARGET GROUP ATTACHMENT IDS
#########################################################
output "target_group_attachment_ids" {
  value = module.target_group_attachments.target_group_attachment_ids
}

#########################################################
# ROUTE53
#########################################################
output "route53_zone_id" {
  description = "Route53 Hosted Zone ID."
  value       = module.route53_hosted_zone.zone_id
}

output "route53_name_servers" {
  description = "Route53 Name Servers."
  value       = module.route53_hosted_zone.name_servers
}

output "route53_record_fqdn" {
  description = "Route53 Alias Record FQDN."
  value       = module.route53_record.fqdn
}

#########################################################
# ACM O/P's
#########################################################
output "certificate_arn" {
  value = module.acm.certificate_arn
}


#########################################################
# S3 BUCKET O/P's
#########################################################

output "bucket_ids" {
  description = "S3 Buckets ID's"
  value       = module.s3_buckets.bucket_ids
}

output "bucket_names" {
  description = "Bucket Names"
  value       = module.s3_buckets.bucket_names
}

output "bucket_arns" {
  description = "S3 Bucket ARN's"
  value       = module.s3_buckets.bucket_arns
}

output "bucket_regional_domains" {
  description = "Bucket Regional Domains"
  value       = module.s3_buckets.bucket_regional_domains
}

output "bucket_hosted_zone_ids" {
  description = "S3 Bucket Hosted Zone ID's"
  value       = module.s3_buckets.bucket_hosted_zone_ids
}



#########################################################
# OBSERVABILITY SNS  O/P's
#########################################################
output "sns_topic_arns" {
  value = module.sns_topics.sns_topic_arns
}

output "sns_topic_ids" {
  value = module.sns_topics.sns_topic_ids
}

output "sns_topic_names" {
  value = module.sns_topics.sns_topic_names
}

#########################################################
# OBSERVABILITY SNS SUBSCRIPTION  O/P's
#########################################################
output "sns_subscription_arns" {
  value = module.sns_subscriptions.sns_subscription_arns
}


#########################################################
# CLOUDWATCH LOG GROUPS
#########################################################

output "cloudwatch_log_group_names" {
  value = module.cloudwatch_log_groups.cloudwatch_log_group_names
}

output "cloudwatch_log_group_arns" {
  value = module.cloudwatch_log_groups.cloudwatch_log_group_arns
}

output "cloudwatch_log_group_ids" {
  value = module.cloudwatch_log_groups.cloudwatch_log_group_ids
}


#########################################################
# CLOUDWATCH METRIC ALARMS
#########################################################
output "metric_alarm_ids" {
  value = module.cloudwatch_metric_alarms.metric_alarm_ids
}

output "metric_alarm_arns" {
  value = module.cloudwatch_metric_alarms.metric_alarm_arns
}

output "metric_alarm_names" {
  value = module.cloudwatch_metric_alarms.metric_alarm_names
}

#########################################################
# CLOUDWATCH AGENT
#########################################################
output "cloudwatch_agent_ssm_parameter_names" {
  description = "CloudWatch Agent SSM Parameter names"
  value       = module.cloudwatch_agents.ssm_parameter_names
}

output "cloudwatch_agent_install_documents" {
  description = "CloudWatch Agent installation SSM documents"
  value       = module.cloudwatch_agents.install_document_names
}

output "cloudwatch_agent_association_ids" {
  description = "CloudWatch Agent configuration association IDs"
  value       = module.cloudwatch_agents.association_ids
}

#########################################################
# CLOUDWATCH DASHBOARDS O/P'S
#########################################################
output "dashboard_names" {
  value = module.cloudwatch_dashboards.dashboard_names
}

output "dashboard_arns" {
  value = module.cloudwatch_dashboards.dashboard_arns
}


#########################################################
# CLOUDWATCH COMPOSITE ALARM O/P'S
#########################################################
output "composite_alarm_ids" {
  value = module.cloudwatch_composite_alarms.composite_alarm_ids
}

output "composite_alarm_arns" {
  value = module.cloudwatch_composite_alarms.composite_alarm_arns
}

output "composite_alarm_names" {
  value = module.cloudwatch_composite_alarms.composite_alarm_names
}


#########################################################
# CLOUDWATCH TRAIL O/P'S
#########################################################
output "cloudtrail_ids" {
  value = module.cloudtrail.cloudtrail_ids
}

output "cloudtrail_arns" {
  value = module.cloudtrail.cloudtrail_arns
}

output "cloudtrail_names" {
  value = module.cloudtrail.cloudtrail_names
}

output "cloudtrail_home_regions" {
  value = module.cloudtrail.cloudtrail_home_regions
}


#########################################################
# CLOUDWATCH LOG METRIC FILTERS O/P'S
#########################################################
output "cloudtrail_metric_filter_ids" {
  value = module.cloudwatch_log_metric_filters.cloudtrail_metric_filter_ids
}

output "cloudtrail_metric_filter_names" {
  value = module.cloudwatch_log_metric_filters.cloudtrail_metric_filter_names
}

output "cloudtrail_metric_filter_log_groups" {
  value = module.cloudwatch_log_metric_filters.cloudtrail_metric_filter_log_groups
}


#########################################################
# CLOUDWATCH AWS CONFIG O/P'S
#########################################################

output "awsconfig_configuration_recorder_id" {
  value = module.aws_config.awsconfig_configuration_recorder_id
}

output "awsconfig_configuration_recorder_name" {
  value = module.aws_config.awsconfig_configuration_recorder_name
}

output "awsconfig_delivery_channel_id" {
  value = module.aws_config.awsconfig_delivery_channel_id
}

output "awsconfig_delivery_channel_name" {
  value = module.aws_config.awsconfig_delivery_channel_name
}

output "awsconfig_configuration_recorder_status_id" {
  value = module.aws_config.awsconfig_configuration_recorder_status_id
}


#########################################################
# CLOUDWATCH AWS CONFIG RULE'S
#########################################################
output "awsconfig_rule_ids" {
  value = module.aws_config_rules.awsconfig_rule_ids
}

output "awsconfig_rule_arns" {
  value = module.aws_config_rules.awsconfig_rule_arns
}

output "awsconfig_rule_names" {
  value = module.aws_config_rules.awsconfig_rule_names
}

output "awsconfig_rule_descriptions" {
  value = module.aws_config_rules.awsconfig_rule_descriptions
}

output "awsconfig_rule_resource_types" {
  value = module.aws_config_rules.awsconfig_rule_resource_types
}


#########################################################
# CLOUDWATCH AWS CONFIG REMEDIATIONS
#########################################################
output "remediation_ids" {
  value = module.aws_config_remediation.remediation_ids
}

output "remediation_config_rule_names" {
  value = module.aws_config_remediation.remediation_config_rule_names
}

output "remediation_target_types" {
  value = module.aws_config_remediation.remediation_target_types
}

output "remediation_target_ids" {
  value = module.aws_config_remediation.remediation_target_ids
}


#########################################################
# CLOUDWATCH AWS CONFIG SECURITY-HUB
#########################################################
output "cloudwatch_security_hub_account_id" {
  value = module.security_hub.cloudwatch_security_hub_account_id
}

output "cloudwatch_security_hub_arn" {
  value = module.security_hub.cloudwatch_security_hub_arn
}

output "cloudwatch_aws_foundational_standard_id" {
  value = module.security_hub.cloudwatch_aws_foundational_standard_id
}

output "cloudwatch_cis_standard_id" {
  value = module.security_hub.cloudwatch_cis_standard_id
}

output "cloudwatch_pci_dss_standard_id" {
  value = module.security_hub.cloudwatch_pci_dss_standard_id
}

#########################################################
# FLUENT BIT O/P's
#########################################################
output "fluentbit_namespace" {
  value = module.fluent_bit.fluentbit_namespace
}

output "fluentbit_service_account_name" {
  value = module.fluent_bit.fluentbit_service_account_name
}

output "fluentbit_daemonset_name" {
  value = module.fluent_bit.fluentbit_daemonset_name
}

output "fluentbit_config_map_name" {
  value = module.fluent_bit.fluentbit_config_map_name
}

output "fluentbit_log_group_name" {
  value = module.fluent_bit.fluentbit_log_group_name
}

output "fluentbit_log_stream_prefix" {
  value = module.fluent_bit.fluentbit_log_stream_prefix
}

output "fluentbit_irsa_role_arn" {
  value = module.fluent_bit.fluentbit_irsa_role_arn
}


#########################################################
# OPEN TELEMETRY O/P's
#########################################################
output "opentelemetry_namespace" {
  value = module.opentelemetry.opentelemetry_namespace
}

output "opentelemetry_service_account_name" {
  value = module.opentelemetry.opentelemetry_service_account_name
}

output "opentelemetry_config_map_name" {
  value = module.opentelemetry.opentelemetry_config_map_name
}

output "opentelemetry_deployment_name" {
  value = module.opentelemetry.opentelemetry_deployment_name
}

output "opentelemetry_service_name" {
  value = module.opentelemetry.opentelemetry_service_name
}

output "opentelemetry_otlp_grpc_endpoint" {
  value = module.opentelemetry.opentelemetry_otlp_grpc_endpoint
}

output "opentelemetry_health_check_endpoint" {
  value = module.opentelemetry.opentelemetry_health_check_endpoint
}







