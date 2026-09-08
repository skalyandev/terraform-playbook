variable "fluent_bit" {

  description = "Fluent Bit configuration for EKS log collection."

  type = object({

    enabled = optional(bool, true)

    namespace = optional(
      string,
      "amazon-cloudwatch"
    )

    service_account_name = optional(
      string,
      "fluent-bit"
    )

    #####################################################
    # IRSA
    #####################################################

    irsa_role_arn = optional(
      string,
      ""
    )

    #####################################################
    # IMAGE
    #####################################################

    image_repository = optional(
      string,
      "public.ecr.aws/aws-observability/aws-for-fluent-bit"
    )

    image_tag = optional(
      string,
      "stable"
    )

    #####################################################
    # CLOUDWATCH
    #####################################################

    log_group_name = optional(
      string,
      "/aws/eks/fluent-bit"
    )

    log_stream_prefix = optional(
      string,
      "eks"
    )

    region = optional(
      string,
      "ap-south-1"
    )

    #####################################################
    # LOG COLLECTION
    #####################################################

    read_from_head = optional(
      bool,
      false
    )

    db = optional(
      string,
      "/fluent-bit/state/fluent-bit.db"
    )

    #####################################################
    # RESOURCES
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
    # TOLERATIONS
    #####################################################

    tolerate_all = optional(
      bool,
      true
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
