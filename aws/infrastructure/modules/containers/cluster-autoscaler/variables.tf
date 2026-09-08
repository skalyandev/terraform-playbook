#########################################################
# CLUSTER AUTOSCALER
#########################################################

variable "cluster_autoscaler" {

  description = "Cluster Autoscaler configuration"

  type = object({

    enabled = bool

    cluster_name = string

    namespace = optional(
      string,
      "kube-system"
    )

    service_account_name = optional(
      string,
      "cluster-autoscaler"
    )

  })

}


#########################################################
# OIDC PROVIDER
#########################################################

variable "oidc_provider_arn" {

  description = "ARN of the EKS IAM OIDC provider"

  type = string

}


#########################################################
# OIDC PROVIDER URL
#########################################################

variable "oidc_provider_url" {

  description = "URL of the EKS IAM OIDC provider"

  type = string

}


#########################################################
# IAM POLICY
#########################################################

variable "iam_policy_path" {

  description = "Path to the Cluster Autoscaler IAM permissions policy"

  type = string

}


#########################################################
# HELM
#########################################################

variable "helm" {

  description = "Cluster Autoscaler Helm configuration"

  type = object({

    repository = optional(
      string,
      "https://kubernetes.github.io/autoscaler"
    )

    chart = optional(
      string,
      "cluster-autoscaler"
    )

    chart_version = string

  })

}


#########################################################
# TAGS
#########################################################

variable "tags" {

  description = "Common AWS resource tags"

  type = map(string)

  default = {}

}
