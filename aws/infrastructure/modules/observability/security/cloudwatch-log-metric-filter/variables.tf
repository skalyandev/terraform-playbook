#########################################################
# CLOUDWATCH LOG METRIC FILTERS
#########################################################

variable "metric_filters" {

  description = "CloudWatch Logs metric filter configurations."

  type = map(object({

    #####################################################
    # LOG GROUP
    #####################################################

    log_group_name = string

    #####################################################
    # FILTER
    #####################################################

    filter_pattern = string

    #####################################################
    # METRIC
    #####################################################

    metric_name = string
    metric_namespace = string
    metric_value = optional(string, "1")
    default_value = optional(number, 0)

    #####################################################
    # OPTIONAL METRIC DIMENSIONS
    #####################################################

    metric_dimensions = optional(map(string), {})

  }))

}
