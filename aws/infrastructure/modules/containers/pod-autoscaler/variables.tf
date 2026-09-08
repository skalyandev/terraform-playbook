#########################################################
# POD AUTOSCALER
#########################################################

variable "pod_autoscaling" {

  description = "Pod Autoscaling / Metrics Server configuration"

  type = object({

    enabled = bool

    namespace = optional(
      string,
      "kube-system"
    )

    service_account_name = optional(
      string,
      "metrics-server"
    )

  })

}


#########################################################
# HELM CONFIGURATION
#########################################################

variable "helm" {

  description = "Metrics Server Helm configuration"

  type = object({

    repository = optional(
      string,
      "https://kubernetes-sigs.github.io/metrics-server/"
    )

    chart = optional(
      string,
      "metrics-server"
    )

    chart_version = string

  })

}


#########################################################
# TAGS
#########################################################

variable "tags" {

  description = "Common tags"

  type = map(string)

  default = {}

}
