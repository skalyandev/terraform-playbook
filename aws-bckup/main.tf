module "vpc" {

  source = "./modules/vpc"

  name           = "${var.name_prefix}-vodafone-vpc"
  vpc_cidr_range = var.vpc_cidr_range

  tags = {
    Environment  = "dev"
    Project      = "raid9"
    Owner        = "platform-team"
    ManagedBy    = "terraform"
  }
}

module "igw" {

  source = "./modules/igw"

  name    = "${var.name_prefix}-vodafone-vpc"
  vpc_id  = module.vpc.vpc_id

  tags = {
    Environment  = "dev"
    Project      = "raid9"
    Owner        = "platform-team"
    ManagedBy    = "terraform"
  }
}


module "public_subnets" {
 
  source = "./modules/subnets"
  vpc_id  = module.vpc.vpc_id
  name    = "${var.name_prefix}-vodafone-subnet"
  public_subnets = var.public_subnets_cidr
  azs = var.azs
  map_public_ip_on_launch = true

  tags = {
    Environment  = "dev"
    Project      = "raid9"
    Owner        = "platform-team"
    ManagedBy    = "terraform"
  }
}
 
module "private_subnets" {

  source = "./modules/subnets"
  vpc_id  = module.vpc.vpc_id
  name    = "${var.name_prefix}-vodafone-subnet"
  private_subnets = var.private_subnets_cidr
  
  azs = var.azs
  map_public_ip_on_launch = false

  tags = {
    Environment  = "dev"
    Project      = "raid9"
    Owner        = "platform-team"
    ManagedBy    = "terraform"
  }
}

module "database_subnets" {

  source = "./modules/subnets"
  vpc_id  = module.vpc.vpc_id
  name    = "${var.name_prefix}-vodafone-subnet"
  database_subnets = var.db_create ? compact(var.database_subnets_cidr) : []

  azs = var.azs
  map_public_ip_on_launch = false

  tags = {
    Environment  = "dev"
    Project      = "raid9"
    Owner        = "platform-team"
    ManagedBy    = "terraform"
  }
}

module "nat_gateway" {

  source = "./modules/nat"

  name = "${var.name_prefix}-vodafone"

  enable_nat_gateway = true

  public_subnet_ids = module.public_subnets.public_subnet_ids

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}

module "route_table" {

  source = "./modules/route_table"

  vpc_id  = module.vpc.vpc_id
  name    = "${var.name_prefix}-vodafone"
  internet_gateway_id = module.igw.internet_gateway_id

  enable_nat_gateway = true

  nat_gateway_id = module.nat_gateway.nat_gateway_id

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}

module "public_route_association" {

  source = "./modules/route_association"

  public_subnet_ids = module.public_subnets.public_subnet_ids

  route_table_id = module.route_table.public_route_table_id
}


#module "private_route_table" {

#  source = "./modules/route_table"

#  name = "${var.name_prefix}-vodafone"
  
#  vpc_id = module.vpc.vpc_id

#  internet_gateway_id = module.igw.internet_gateway_id
#  enable_nat_gateway = true

#  nat_gateway_id = module.nat_gateway.nat_gateway_id

#  tags = {
#    Environment = "dev"
#    Project     = "raid9"
#    Owner       = "platform-team"
#    ManagedBy   = "terraform"
#  }
#}


module "private_route_association" {

  source = "./modules/route_association"

  private_subnet_ids = module.private_subnets.private_subnet_ids

  route_table_id = module.route_table.private_route_table_id

}


########################## STAGE-2  ########################
#BASTION MODULE
############################################################
module "bastion" {
  source            = "./modules/bastion"
  name              = "${var.name_prefix}"
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.public_subnets.public_subnet_ids[0]
  instance_type     = "m7i-flex.large"
  key_name          = "dev-bastion-kp"
  bastion_ssh_key_1 = "ssh-rsa dummy-testing-key1"
  bastion_ssh_key_2 = "ssh-rsa dummy-testing-key2"
  #bastion_ssh_key_1 = file("~/.ssh/id_rsa.pub")
  
  alb_sg_id = module.alb_security_group.alb_sg_id
  instance_profile_name = module.iam.instance_profile_name
  associate_public_ip_address = var.associate_public_ip_address
  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}


##############################################################
# IAM MODULE
##############################################################

module "iam" {

  source = "./modules/iam"
  name   = "${var.name_prefix}"

  #S3 Buckets
  bucket_arn = module.s3_buckets.bucket_arn 
  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }

}

##############################################################
# SSM MODULE
##############################################################

module "ssm" {

  source = "./modules/ssm"

  iam_role_name = module.iam.role_name
}

##############################################################
# CLOUD WATCH MODULE
##############################################################

module "cloudwatch" {

  source = "./modules/cloudwatch"

  name   = "${var.name_prefix}"

  instance_id = module.bastion.bastion_instance_id

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}


##############################################################
# S3 BUCKET CREATION
##############################################################
module "s3_buckets" {
  source = "./modules/s3_bucket"

  bastion_role_arn = module.iam.bastion_role_arn
  
  bucket_name = "vodafone-dev-s3"
  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
  
}

##############################################################
# EKS IAM MODULE
##############################################################
module "eks_cluster_role" {
  source = "./modules/eks_cluster_role"

  name = "${var.name_prefix}"

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}

##############################################################
# EKS SECURITY GRP MODULE
##############################################################
module "eks_security_group" {
  
  source = "./modules/eks_security_group"

  name = "${var.name_prefix}"

  vpc_id = module.vpc.vpc_id

  bastion_sg_id = module.bastion.bastion_security_group_id

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}

##############################################################
# EKS CLUSTER MODULE
##############################################################
module "eks_cluster" {

  source           = "./modules/eks_cluster"
  cluster_name     = "${var.name_prefix}-eks-cluster"
  cluster_version  = "1.32"
  role_arn         = module.eks_cluster_role.eks_role_arn
  subnet_ids       = module.private_subnets.private_subnet_ids
  kms_key_arn      = module.eks_security.kms_key_arn
  security_group_ids = [ 
    module.eks_security_group.security_group_id
  ]
  
  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}

##############################################################
# EKS CLUSTER NODE ROLE MODULE
##############################################################
module "eks_node_role" {

  source = "./modules/eks_node_role"

  role_name = "${var.name_prefix}-eks-node-role"

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}

##############################################################
# EKS LAUNCH TEMPLATE MODULE
##############################################################
module "eks_launch_template" {

  source = "./modules/eks_launch_template"

  name = "${var.name_prefix}-eks-node-lt"

  instance_type = "t3.micro"

  volume_size = 50

  security_group_ids = [
    module.eks_security_group.security_group_id
  ]

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}


##############################################################
# EKS NODE GROUP
##############################################################
module "eks_nodegroup" {

  source = "./modules/eks_nodegroup"

  cluster_name = module.eks_cluster.cluster_name

  nodegroup_name = "primary"

  node_role_arn = module.eks_node_role.node_role_arn

  subnet_ids = module.private_subnets.private_subnet_ids

  launch_template_id =module.eks_launch_template.launch_template_id

  desired_size = 2

  min_size = 2

  max_size = 4
}

##############################################################
# EKS OIDC Provider
##############################################################
module "eks_oidc_provider" {

  source = "./modules/eks_oidc_provider"

  oidc_issuer_url = module.eks_cluster.oidc_issuer

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}


##############################################################
# EKS EBS CSI IRSA
##############################################################
module "eks_ebs_csi_irsa" {

  count = var.enable_ebs_csi ? 1 : 0

  source = "./modules/eks_ebs_csi_irsa"

  role_name = "${var.name_prefix}-eks-ebs-csi-role"

  oidc_provider_arn = module.eks_oidc_provider.oidc_provider_arn

  oidc_provider_url = module.eks_oidc_provider.oidc_provider_url

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}

##############################################################
# EKS EBS AddOn
##############################################################
module "eks_addon_ebs_csi" {

  count = var.enable_ebs_csi ? 1 : 0

  source = "./modules/eks_addon_ebs_csi"

  cluster_name = module.eks_cluster.cluster_name

  service_account_role_arn = module.eks_ebs_csi_irsa[0].role_arn
}

##############################################################
# EKS CoreDNS 
##############################################################

module "eks_addon_coredns" {

  source = "./modules/eks_addon_coredns"

  cluster_name = module.eks_cluster.cluster_name
}

##############################################################
# EKS VPS CNI ADDON
##############################################################
module "eks_addon_vpc_cni" {

  source = "./modules/eks_addon_vpc_cni"

  cluster_name = module.eks_cluster.cluster_name

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }

  depends_on = [
    module.eks_cluster,
    module.eks_nodegroup
  ]
}

############################################################
# KUBE PROXY ADDON
############################################################

module "eks_addon_kube_proxy" {

  source = "./modules/eks_addon_kube_proxy"

  cluster_name = module.eks_cluster.cluster_name

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }

  depends_on = [
    module.eks_cluster,
    module.eks_nodegroup
  ]
}


############################################################
# EKS SECURITY
############################################################
module "eks_security" {

  source = "./modules/eks_security"

  environment = "${var.name_prefix}"

  cluster_name = module.eks_cluster.cluster_name

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}


#########################################################
# ALB SECURITY GRP
#########################################################

module "alb_security_group" {
  source = "./modules/alb_security_group"

  environment = "${var.name_prefix}"
  vpc_id = module.vpc.vpc_id

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}

#########################################################
# ALB TARGET GRP
#########################################################

module "alb_target_group" {
  source = "./modules/alb_target_group"

  environment = "${var.name_prefix}"
  vpc_id = module.vpc.vpc_id
  bastion_instance_id = module.bastion.bastion_instance_id


  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}

#########################################################
# AMAZON LOAD BALANCER
#########################################################

module "alb" {
  source = "./modules/alb"

  environment = "${var.name_prefix}"
 
  public_subnets = module.public_subnets.public_subnet_ids

  alb_sg_id = module.alb_security_group.alb_sg_id
  
  target_group_arn = module.alb_target_group.target_group_arn


  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}







