#########################################################
# KINESIS DATA FIREHOSE
#########################################################

variable "firehose_streams" {

  description = "Kinesis Data Firehose delivery streams."

  type = map(object({

    #####################################################
    # DELIVERY STREAM
    #####################################################

    name = optional(string)

    #####################################################
    # DESTINATION
    #####################################################

    destination = string

    #####################################################
    # S3 CONFIGURATION
    #####################################################

    bucket_arn = optional(string)

    #####################################################
    # BUFFERING
    #####################################################

    buffer_size = optional(number, 5)

    buffer_interval = optional(number, 300)

    #####################################################
    # COMPRESSION
    #####################################################

    compression_format = optional(string, "GZIP")

    #####################################################
    # ERROR OUTPUT
    #####################################################

    error_output_prefix = optional(string, "errors/")

    #####################################################
    # LOGGING
    #####################################################

    enable_cloudwatch_logging = optional(bool, false)

    #####################################################
    # TAGS
    #####################################################

    tags = optional(map(string), {})

  }))

}


#########################################################
# IAM ROLE ARNS
#########################################################

variable "iam_role_arns" {

  description = "IAM role ARNs used by Firehose delivery streams."

  type = map(string)

  default = {}

}


#########################################################
# TAGS
#########################################################

variable "tags" {

  description = "Common tags."

  type = map(string)

  default = {}

}
