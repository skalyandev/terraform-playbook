#########################################
# VPC O/P's
#########################################
output "vpc_id" {
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "VPC ARN"
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "VPC CIDR"
  value       =  module.vpc.vpc_cidr_block
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
output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}


output "subnet_ids_by_type" {
  value = module.subnets.subnet_ids_by_type
}

output "subnet_route_tables" {
  value = module.subnets.subnet_route_tables
}

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
output "allocation_id" {
  value = module.elastic_ip.allocation_id
}

output "elastic_public_ip" {
  value = module.elastic_ip.elastic_public_ip
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
# EC2 O/P's
#######################################################
output "ec2_instance_ids" {
  value = module.ec2.instance_ids
}

output "ec2_instance_arns" {
  value = module.ec2.instance_arns
}

output "ec2_private_ips" {
  value = module.ec2.private_ips
}

output "ec2_public_ips" {
  value = module.ec2.public_ips
}

output "ec2_availability_zones" {
  value = module.ec2.availability_zones
}

output "ec2_instance_states" {
  value = module.ec2.instance_states
}

output "ec2_instances" {
  value = module.ec2.instances
}

#######################################################
# EKS O/P's
#######################################################
output "cluster_ids" {
  value = module.eks_cluster.cluster_ids
}

output "cluster_arns" {
  value = module.eks_cluster.cluster_arns
}

output "cluster_endpoints" {
  value = module.eks_cluster.cluster_endpoints
}

output "cluster_certificate_authorities" {
  value = module.eks_cluster.cluster_certificate_authorities
}

output "cluster_versions" {
  value = module.eks_cluster.cluster_versions
}

output "cluster_names" {
  value = module.eks_cluster.cluster_names
}


output "access_entries" {
  value = module.eks_access.access_entries
}



