#########################################################
# OPENTELEMETRY
#########################################################

variable "opentelemetry" {

  description = "OpenTelemetry Collector configuration for EKS."

  type = object({

    #####################################################
    # ENABLE / DISABLE
    #####################################################

    enabled = optional(
      bool,
      false
    )

    #####################################################
    # KUBERNETES
    #####################################################

    namespace = optional(
      string,
      "opentelemetry"
    )

    service_account_name = optional(
      string,
      "opentelemetry-collector"
    )

    #####################################################
    # DEPLOYMENT
    #####################################################

    mode = optional(
      string,
      "deployment"
    )

    replicas = optional(
      number,
      1
    )

    #####################################################
    # IMAGE
    #####################################################

    image_repository = optional(
      string,
      "otel/opentelemetry-collector-contrib"
    )

    image_tag = optional(
      string,
      "latest"
    )

    #####################################################
    # OTLP
    #####################################################

    otlp_grpc_port = optional(
      number,
      4317
    )

    otlp_http_port = optional(
      number,
      4318
    )

    #####################################################
    # HEALTH CHECK
    #####################################################

    health_check_port = optional(
      number,
      13133
    )

    #####################################################
    # PROMETHEUS
    #####################################################

    prometheus_enabled = optional(
      bool,
      false
    )

    prometheus_port = optional(
      number,
      8889
    )

    #####################################################
    # AWS X-RAY
    #####################################################

    aws_xray_enabled = optional(
      bool,
      false
    )

    #####################################################
    # AWS CLOUDWATCH
    #####################################################

    cloudwatch_enabled = optional(
      bool,
      false
    )

    #####################################################
    # OTLP EXPORTER
    #####################################################

    otlp_exporter_enabled = optional(
      bool,
      false
    )

    otlp_exporter_endpoint = optional(
      string,
      ""
    )

    #####################################################
    # RESOURCE CONFIGURATION
    #####################################################

    cpu_request = optional(
      string,
      "100m"
    )

    memory_request = optional(
      string,
      "128Mi"
    )

    cpu_limit = optional(
      string,
      "500m"
    )

    memory_limit = optional(
      string,
      "512Mi"
    )

    #####################################################
    # ENVIRONMENT
    #####################################################

    environment = optional(
      string,
      "dev"
    )

    #####################################################
    # TAGS
    #####################################################

    tags = optional(
      map(string),
      {}
    )

  })

  default = {}

}


