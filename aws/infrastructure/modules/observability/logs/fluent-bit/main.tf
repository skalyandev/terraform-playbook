#########################################################
# FLUENT BIT
#########################################################

#########################################################
# KUBERNETES NAMESPACE
#########################################################

resource "kubernetes_namespace" "this" {

  count = var.fluent_bit.enabled ? 1 : 0

  metadata {
    name = var.fluent_bit.namespace
  }

}


#########################################################
# SERVICE ACCOUNT
#########################################################

resource "kubernetes_service_account" "this" {

  count = var.fluent_bit.enabled ? 1 : 0

  metadata {

    name = var.fluent_bit.service_account_name

    namespace = var.fluent_bit.namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = var.fluent_bit.irsa_role_arn
    }

  }

  depends_on = [
    kubernetes_namespace.this
  ]

}


#########################################################
# FLUENT BIT CONFIGURATION
#########################################################

resource "kubernetes_config_map" "this" {

  count = var.fluent_bit.enabled ? 1 : 0

  metadata {

    name = "fluent-bit-config"

    namespace = var.fluent_bit.namespace

  }

  data = {

    "fluent-bit.conf" = <<-EOF

      [SERVICE]
          Flush        5
          Daemon       Off
          Log_Level    info
          Parsers_File parsers.conf
          HTTP_Server  On
          HTTP_Listen  0.0.0.0
          HTTP_PORT    2020

      [INPUT]
          Name              tail
          Path              /var/log/containers/*.log
          Parser            cri
          Tag               kube.*
          Mem_Buf_Limit     50MB
          Skip_Long_Lines   On
          Refresh_Interval  10
          DB                ${var.fluent_bit.db}
          Read_from_Head    ${var.fluent_bit.read_from_head ? "True" : "False"}

      [INPUT]
          Name              systemd
          Tag               host.*
          Systemd_Filter     _SYSTEMD_UNIT=kubelet.service
          Read_From_Tail     ${var.fluent_bit.read_from_head ? "False" : "True"}

      [FILTER]
          Name                kubernetes
          Match               kube.*
          Kube_URL             https://kubernetes.default.svc:443
          Kube_CA_File         /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
          Kube_Token_File      /var/run/secrets/kubernetes.io/serviceaccount/token
          Kube_Tag_Prefix      kube.var.log.containers.
          Merge_Log             On
          Keep_Log              Off
          K8S-Logging.Parser    On
          K8S-Logging.Exclude   On

      [OUTPUT]
          Name                cloudwatch_logs
          Match               kube.*
          region              ${var.fluent_bit.region}
          log_group_name      ${var.fluent_bit.log_group_name}
          log_stream_prefix   ${var.fluent_bit.log_stream_prefix}
          auto_create_group   true

      [OUTPUT]
          Name                cloudwatch_logs
          Match               host.*
          region              ${var.fluent_bit.region}
          log_group_name      ${var.fluent_bit.log_group_name}
          log_stream_prefix   ${var.fluent_bit.log_stream_prefix}-host
          auto_create_group   true

    EOF

    "parsers.conf" = <<-EOF

      [PARSER]
          Name        cri
          Format      regex
          Regex       ^(?<time>[^ ]+) (?<stream>stdout|stderr) (?<logtag>[^ ]*) (?<message>.*)$
          Time_Key    time
          Time_Format %Y-%m-%dT%H:%M:%S.%L%z
          Time_Keep   On

    EOF

  }

}


#########################################################
# FLUENT BIT DAEMONSET
#########################################################

resource "kubernetes_daemon_set_v1" "this" {

  count = var.fluent_bit.enabled ? 1 : 0

  metadata {

    name = "fluent-bit"

    namespace = var.fluent_bit.namespace

    labels = {
      app = "fluent-bit"
    }

  }

  spec {

    selector {

      match_labels = {
        app = "fluent-bit"
      }

    }

    template {

      metadata {

        labels = {
          app = "fluent-bit"
        }

      }

      spec {

        service_account_name = var.fluent_bit.service_account_name

        #################################################
        # TOLERATIONS
        #################################################

        dynamic "toleration" {

          for_each = var.fluent_bit.tolerate_all ? [1] : []

          content {

            operator = "Exists"

          }

        }

        #################################################
        # CONTAINER
        #################################################

        container {

          name = "fluent-bit"

          image = "${var.fluent_bit.image_repository}:${var.fluent_bit.image_tag}"

          image_pull_policy = "IfNotPresent"

          command = [
            "/fluent-bit/bin/fluent-bit"
          ]

          args = [
            "-c",
            "/fluent-bit/etc/fluent-bit.conf"
          ]

          #################################################
          # PORT
          #################################################

          port {

            name           = "http"
            container_port = 2020
            protocol       = "TCP"

          }

          #################################################
          # RESOURCES
          #################################################

          resources {

            requests = {
              cpu    = var.fluent_bit.cpu_request
              memory = var.fluent_bit.memory_request
            }

            limits = {
              cpu    = var.fluent_bit.cpu_limit
              memory = var.fluent_bit.memory_limit
            }

          }

          #################################################
          # CONFIGURATION
          #################################################

          volume_mount {

            name       = "config"
            mount_path = "/fluent-bit/etc/fluent-bit.conf"
            sub_path   = "fluent-bit.conf"
            read_only  = true

          }

          volume_mount {

            name       = "config"
            mount_path = "/fluent-bit/etc/parsers.conf"
            sub_path   = "parsers.conf"
            read_only  = true

          }

          volume_mount {

            name       = "varlog"
            mount_path = "/var/log"

            read_only = true

          }

          volume_mount {

            name       = "fluentbit-db"
            mount_path = "/var/log"

          }

        }

        #################################################
        # VOLUMES
        #################################################

        volume {

          name = "config"

          config_map {

            name = kubernetes_config_map.this[0].metadata[0].name

          }

        }

        volume {

          name = "varlog"

          host_path {

            path = "/var/log"

          }

        }

        volume {

          name = "fluentbit-db"

          host_path {

            path = "/var/log/fluent-bit"

            type = "DirectoryOrCreate"

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


