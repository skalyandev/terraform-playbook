variable "kube_prometheus_stack" {
  description = "Configuration for the kube-prometheus-stack Helm release."

  type = object({
    enabled = bool

    release_name = string
    namespace    = string

    repository    = string
    chart_name    = string
    chart_version = string

    #####################################################
    # PROMETHEUS
    #####################################################

    prometheus_enabled         = bool
    prometheus_retention       = string
    prometheus_storage_class   = string
    prometheus_storage_size    = string

    prometheus_cpu_request     = string
    prometheus_memory_request  = string
    prometheus_cpu_limit       = string
    prometheus_memory_limit    = string

    #####################################################
    # GRAFANA
    #####################################################

    grafana_enabled        = bool
    grafana_storage_class  = string
    grafana_storage_size   = string

    grafana_cpu_request    = string
    grafana_memory_request = string
    grafana_cpu_limit      = string
    grafana_memory_limit   = string

    #####################################################
    # ALERTMANAGER
    #####################################################

    alertmanager_enabled        = bool
    alertmanager_storage_class  = string
    alertmanager_storage_size   = string

    #####################################################
    # KUBERNETES METRICS
    #####################################################

    kube_state_metrics_enabled = bool
    node_exporter_enabled      = bool

    kube_state_metrics_cpu_request    = string
    kube_state_metrics_memory_request = string

    node_exporter_cpu_request    = string
    node_exporter_memory_request = string

    #####################################################
    # GENERAL
    #####################################################

    tags = map(string)
  })
}
