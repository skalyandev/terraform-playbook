variable "cluster_name" {

  description = "EKS Cluster Name"

  type = string

}


variable "oidc_provider_url" {

  description = "EKS OIDC Provider URL"

  type = string

}


variable "oidc_provider_arn" {

  description = "EKS OIDC Provider ARN"

  type = string

}


variable "domain_name" {

  description = "Route53 Domain"

  type = string

}


variable "zone_id" {

  description = "Route53 Hosted Zone ID"

  type = string

}


variable "region" {

  description = "AWS Region"

  type = string

}


variable "tags" {

  type = map(string)

  default = {}

}
