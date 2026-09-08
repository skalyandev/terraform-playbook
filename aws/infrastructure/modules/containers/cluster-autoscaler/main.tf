#########################################################
# AWS REGION
#########################################################

data "aws_region" "current" {}


#########################################################
# CLUSTER AUTOSCALER LOCALS
#########################################################

locals {

  name = "cluster-autoscaler"

  role_name = "${var.cluster_autoscaler.cluster_name}-${local.name}"

}
