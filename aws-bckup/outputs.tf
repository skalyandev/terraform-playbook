output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.public_subnets.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.private_subnets.private_subnet_ids
}

output "internet_gateway_id" {
  value = module.igw.internet_gateway_id
}

output "nat_gateway_id" {
  value = module.nat_gateway.nat_gateway_id
}

# ROUTE TABLE IDS
output "public_route_table_id" {
  value = module.route_table.public_route_table_id
}

output "private_route_table_id" {
  value = module.route_table.private_route_table_id
}

output "ams_id" {
  value = module.bastion.ami_id
}

output "bastion_security_group_id" {
  value = module.bastion.bastion_security_group_id
}

# IAM PROFILE NAME
output "instance_profile_name" {
  value = module.iam.instance_profile_name
}

# IAM ROLE NAME
output "role_name" {
  value = module.iam.role_name
}

#IAM BASTION ROLE ARN
output "bastion_role_arn" {
  value = module.iam.bastion_role_arn

}

output "ssm_enabled" {
  value = module.ssm.ssm_enabled
}

#EKS ROLE
output "eks_role_arn" {
  value = module.eks_cluster_role.eks_role_arn
}

output "eks_role_name" {
  value = module.eks_cluster_role.eks_role_name
}

#EKS Security Grp
output "security_group_id" {
  value = module.eks_security_group.security_group_id
}

# EKS CLUSTER

output "cluster_name" {
  value = module.eks_cluster.cluster_name
}

output "cluster_arn" {
  value = module.eks_cluster.cluster_arn
}

output "cluster_endpoint" {
  value = module.eks_cluster.cluster_endpoint
}

output "oidc_issuer" {
  value = module.eks_cluster.oidc_issuer
}

# EKS NODE ROLE
output "node_role_arn" {
  value = module.eks_node_role.node_role_arn
}

#EKS Launch Template
output "launch_template_id" {
  value = module.eks_launch_template.launch_template_id
}

output "launch_template_version" {
  value = module.eks_launch_template.launch_template_version
}

#EKS NODE GRP
output "nodegroup_name" {
  value = module.eks_nodegroup.nodegroup_name
}

#EKS OIDC
output "oidc_provider_arn" {
  value = module.eks_oidc_provider.oidc_provider_arn
}

output "oidc_provider_url" {
  value = module.eks_oidc_provider.oidc_provider_url
}

# EKS EBS CSI IRSA
output "role_arn" {
  value = try(module.eks_ebs_csi_irsa[0].role_arn, null)
}

# EKS EBS AddOn
output "addon_name" {
  value = try(module.eks_addon_ebs_csi[0].addon_name, null)
} 

output "addon_version" {
  value = try(module.eks_addon_ebs_csi[0].addon_version, null)
}

#EKS AddOn VPC CNI
output "addon_vpc_name" {
  value = module.eks_addon_vpc_cni.addon_name
}

output "addon_vpc_arn" {
  value = module.eks_addon_vpc_cni.addon_arn
}

output "addon_vpc_version" {
  value = module.eks_addon_vpc_cni.addon_version
}

# EKS Kube Proxy 
output "kube_proxy_addon_name" {
  value = module.eks_addon_kube_proxy.addon_name
}

output "kube_proxy_addon_arn" {
  value = module.eks_addon_kube_proxy.addon_arn
}

output "kube_proxy_addon_version" {
  value = module.eks_addon_kube_proxy.addon_version
}

#EKS Security
output "kms_key_arn" {
  value = module.eks_security.kms_key_arn
}

output "kms_key_id" {
  value = module.eks_security.kms_key_id
}

output "kms_alias" {
  value = module.eks_security.kms_alias
}

#S3 Buckets 
output "bucket_name" {
  value = module.s3_buckets.bucket_name
}

#S3 Bucket Arn
output "bucket_arn" {
  value = module.s3_buckets.bucket_arn
}


#ALB SG ID
output "bastion_sg_id" {
 value = module.alb_security_group.alb_sg_id
}



