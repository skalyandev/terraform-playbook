#########################################################
# EKS CLUSTER
#########################################################

variable "cluster_name" {

  description = "EKS Cluster Name"

  type = string

}


#########################################################
# AWS REGION
#########################################################

variable "region" {

  description = "AWS Region"

  type = string

}


#########################################################
# VPC ID
#########################################################

variable "vpc_id" {

  description = "VPC ID"

  type = string

}


#########################################################
# HELM VERSION
#########################################################

variable "chart_version" {

  description = "AWS Load Balancer Controller Helm Chart Version"

  type = string

  default = "1.13.4"

}


#########################################################
# SERVICE ACCOUNT NAME
#########################################################

variable "service_account_name" {

  description = "AWS Load Balancer Controller Service Account"

  type = string

  default = "aws-load-balancer-controller"

}

#########################################################
# OIDC PROVIDER ARN
#########################################################

variable "oidc_provider_arn" {

  description = "EKS OIDC Provider ARN"

  type = string

}


#########################################################
# OIDC PROVIDER URL
#########################################################

variable "oidc_provider_url" {

  description = "EKS OIDC Provider URL"

  type = string

}

#########################################################
# TAGS
#########################################################

variable "tags" {

  description = "Resource Tags"
  type = map(string)
  default = {}

}
