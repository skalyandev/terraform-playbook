resource "aws_eks_cluster" "this" {

  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = var.role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = var.security_group_ids
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  encryption_config {

     provider {
       key_arn = var.kms_key_arn
     }

    resources = ["secrets"]
  }

  tags = var.tags
}
