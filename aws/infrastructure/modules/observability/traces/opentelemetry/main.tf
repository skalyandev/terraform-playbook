#########################################################
# OPENTELEMETRY COLLECTOR
#########################################################

#########################################################
# NAMESPACE
#########################################################

resource "kubernetes_namespace" "this" {

  count = var.opentelemetry.enabled ? 1 : 0

  metadata {

    name = var.opentelemetry.namespace

  }

}


#########################################################
# SERVICE ACCOUNT
#########################################################

resource "kubernetes_service_account" "this" {

  count = var.opentelemetry.enabled ? 1 : 0

  metadata {

    name = var.opentelemetry.service_account_name

    namespace = var.opentelemetry.namespace

  }

  depends_on = [
    kubernetes_namespace.this
  ]

}


#########################################################
# OPENTELEMETRY CONFIGURATION
#########################################################

resource "kubernetes_config_map" "this" {

  count = var.opentelemetry.enabled ? 1 : 0

  metadata {

    name = "opentelemetry-collector-config"

    namespace = var.opentelemetry.namespace

  }

  data = {

    "otel-collector-config.yaml" = <<-EOF

      receivers:

        otlp:

          protocols:

            grpc:
              endpoint: 0.0.0.0:${var.opentelemetry.otlp_grpc_port}

            http:
              endpoint: 0.0.0.0:${var.opentelemetry.otlp_http_port}


      processors:

        memory_limiter:

          check_interval: 5s
          limit_mib: 400
          spike_limit_mib: 100

        batch:

          timeout: 5s
          send_batch_size: 1024


      exporters:

        debug:

          verbosity: basic

      service:

        extensions:
          - health_check

        pipelines:

          traces:

            receivers:
              - otlp

            processors:
              - memory_limiter
              - batch

            exporters:
              - debug

          metrics:

            receivers:
              - otlp

            processors:
              - memory_limiter
              - batch

            exporters:
              - debug

          logs:

            receivers:
              - otlp

            processors:
              - memory_limiter
              - batch

            exporters:
              - debug


      extensions:

        health_check:

          endpoint: 0.0.0.0:${var.opentelemetry.health_check_port}

    EOF

  }

}


#########################################################
# OPENTELEMETRY DEPLOYMENT
#########################################################

resource "kubernetes_deployment_v1" "this" {

  count = (
    var.opentelemetry.enabled &&
    var.opentelemetry.mode == "deployment"
  ) ? 1 : 0

  metadata {

    name = "opentelemetry-collector"

    namespace = var.opentelemetry.namespace

    labels = {
      app = "opentelemetry-collector"
    }

  }

  spec {

    replicas = var.opentelemetry.replicas

    selector {

      match_labels = {
        app = "opentelemetry-collector"
      }

    }

    template {

      metadata {

        labels = {
          app = "opentelemetry-collector"
        }

      }

      spec {

        service_account_name = var.opentelemetry.service_account_name

        container {

          name = "opentelemetry-collector"

          image = "${var.opentelemetry.image_repository}:${var.opentelemetry.image_tag}"

          image_pull_policy = "IfNotPresent"

          command = [
            "/otelcol-contrib"
          ]

          args = [
            "--config=/etc/otelcol-contrib/otel-collector-config.yaml"
          ]

          #################################################
          # OTLP GRPC
          #################################################

          port {

            name           = "otlp-grpc"
            container_port = var.opentelemetry.otlp_grpc_port
            protocol       = "TCP"

          }

          #################################################
          # OTLP HTTP
          #################################################

          port {

            name           = "otlp-http"
            container_port = var.opentelemetry.otlp_http_port
            protocol       = "TCP"

          }

          #################################################
          # HEALTH CHECK
          #################################################

          port {

            name           = "health"
            container_port = var.opentelemetry.health_check_port
            protocol       = "TCP"

          }

          #################################################
          # PROMETHEUS
          #################################################

          dynamic "port" {

            for_each = var.opentelemetry.prometheus_enabled ? [1] : []

            content {

              name = "prometheus"

              container_port = var.opentelemetry.prometheus_port

              protocol = "TCP"

            }

          }

          #################################################
          # RESOURCES
          #################################################

          resources {

            requests = {

              cpu = var.opentelemetry.cpu_request

              memory = var.opentelemetry.memory_request

            }

            limits = {

              cpu = var.opentelemetry.cpu_limit

              memory = var.opentelemetry.memory_limit

            }

          }

          #################################################
          # CONFIGURATION
          #################################################

          volume_mount {

            name = "config"

            mount_path = "/etc/otelcol-contrib"

            read_only = true

          }

          #################################################
          # HEALTH PROBE
          #################################################

          liveness_probe {

            http_get {

              path = "/"

              port = var.opentelemetry.health_check_port

            }

            initial_delay_seconds = 10

            period_seconds = 10

            timeout_seconds = 5

            failure_threshold = 3

          }

          readiness_probe {

            http_get {

              path = "/"

              port = var.opentelemetry.health_check_port

            }

            initial_delay_seconds = 5

            period_seconds = 10

            timeout_seconds = 5

            failure_threshold = 3

          }

        }

        #################################################
        # CONFIGURATION VOLUME
        #################################################

        volume {

          name = "config"

          config_map {

            name = kubernetes_config_map.this[0].metadata[0].name

          }

        }

      }

    }

  }

  depends_on = [

    kubernetes_service_account.this,

    kubernetes_config_map.this

  ]

}


#########################################################
# OPENTELEMETRY SERVICE
#########################################################

resource "kubernetes_service_v1" "this" {

  count = var.opentelemetry.enabled ? 1 : 0

  metadata {

    name = "opentelemetry-collector"

    namespace = var.opentelemetry.namespace

  }

  spec {

    selector = {

      app = "opentelemetry-collector"

    }

    port {

      name = "otlp-grpc"

      port = var.opentelemetry.otlp_grpc_port

      target_port = var.opentelemetry.otlp_grpc_port

      protocol = "TCP"

    }

    port {

      name = "otlp-http"

      port = var.opentelemetry.otlp_http_port

      target_port = var.opentelemetry.otlp_http_port

      protocol = "TCP"

    }

    port {

      name = "health"

      port = var.opentelemetry.health_check_port

      target_port = var.opentelemetry.health_check_port

      protocol = "TCP"

    }

    dynamic "port" {

      for_each = var.opentelemetry.prometheus_enabled ? [1] : []

      content {

        name = "prometheus"

        port = var.opentelemetry.prometheus_port

        target_port = var.opentelemetry.prometheus_port

        protocol = "TCP"

      }

    }

    type = "ClusterIP"

  }

  depends_on = [

    kubernetes_deployment_v1.this

  ]

}


