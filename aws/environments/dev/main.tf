#####################################################
# VPC MODULE
#####################################################
module "vpc" {

  source = "../../modules/networking/vpc"

  name       = "${local.name_prefix}-vpc"
  cidr_block     = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = local.common_tags

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
  
  name = "${local.name_prefix}-igw"
  vpc_id = module.vpc.vpc_id
  tags = local.common_tags

}

#########################################################
# ELASTIC-IP MODULE
#########################################################
module "elastic_ip" {

  source = "../../modules/networking/elastic-ip"

  name = "${local.name_prefix}-nat-eip"
  tags = local.common_tags
}

###########################################################
# NAT GW MODULE
###########################################################
module "nat_gateway" {

  source = "../../modules/networking/nat-gateway"

  nat_gateways = {

    nat-a = {
      allocation_id = module.elastic_ip.allocation_id
      subnet_id     = module.subnets.subnet_ids_by_type["public"][0]
    }

  }

  tags = local.common_tags
}

############################################################
# ROUTE TABLES MODULE
############################################################

module "route_tables" {

  source = "../../modules/networking/route-table"

  vpc_id = module.vpc.vpc_id
  route_tables = var.route_tables
  tags = local.common_tags

}

########################################################
# ROUTE TABLE ASSOCIATIONS
########################################################
module "route_table_associations" {

  source = "../../modules/networking/route-table-association"

  subnet_ids_by_type = module.subnets.subnet_ids_by_type

  route_table_ids = module.route_tables.route_table_ids
  
  tags = local.common_tags 
 
}

########################################################
# ROUTES
########################################################

module "routes" {

  source = "../../modules/networking/routes"
  
  routes = var.routes
  route_table_ids = module.route_tables.route_table_ids
  internet_gateway_id = module.igw.internet_gateway_id
  nat_gateway_ids = module.nat_gateway.nat_gateway_ids
  tags = local.common_tags
}

########################################################
# SECURITY GROUPS
########################################################

module "security_groups" {

  source = "../../modules/security/security-group"

  vpc_id = module.vpc.vpc_id
  security_groups = var.security_groups
  tags = local.common_tags

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

  roles = var.roles

  tags = local.common_tags

}

#########################################################
# IAM POLICIES
#########################################################

module "iam_policies" {

  source = "../../modules/iam/policy"

  policies = var.policies

  tags = local.common_tags

}

#########################################################
# ROLE POLICY ATTACHMENTS
#########################################################

module "role_policy_attachments" {

  source = "../../modules/iam/role-policy-attachment"

  attachments = var.attachments
  role_names = module.iam_roles.role_names
  policy_arns = module.iam_policies.policy_arns

}

#########################################################
# INSTANCE PROFILE
#########################################################

module "instance_profiles" {

  source = "../../modules/iam/instance-profile"

  instance_profiles = var.instance_profiles

  role_names = module.iam_roles.role_names

  tags = local.common_tags

}

#########################################################
# AMI MODULE
#########################################################

module "amis" {

  source = "../../modules/compute/ami"

  amis = var.amis

}

#########################################################
# EC2
#########################################################

module "ec2" {

  source = "../../modules/compute/ec2"

  instances = var.instances
  ami_ids = module.amis.ami_ids
  subnet_ids = module.subnets.public_subnet_ids["bastion"]
  security_group_ids = module.security_groups.security_group_ids
  instance_profile_names = module.instance_profiles.instance_profile_names
  tags = local.common_tags

}

#########################################################
# EKS CLUSTER
#########################################################

module "eks_cluster" {

  source = "../../modules/containers/eks-cluster"

  eks_clusters = var.eks_clusters
  role_arns = module.iam_roles.role_arns
  private_subnet_ids = module.subnets.private_subnet_ids["eks"]
  security_group_ids = module.security_groups.security_group_ids
  tags = local.common_tags

}


#########################################################
# EKS NODE GROUPS
#########################################################

module "eks_node_groups" {

  source = "../../modules/containers/eks-node-group"
  
  eks_node_groups = var.eks_node_groups
  cluster_names = module.eks_cluster.cluster_ids
  role_arns = module.iam_roles.role_arns
  private_subnet_ids = module.subnets.private_subnet_ids["eks"]
  tags = local.common_tags

}

#########################################################
# EKS ACCESS
#########################################################

module "eks_access" {

  source = "../../modules/containers/eks-access"
  cluster_names = module.eks_cluster.cluster_names
  access_entries = var.access_entries

}




