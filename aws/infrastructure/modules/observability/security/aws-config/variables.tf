#########################################################
# AWS CONFIG
#########################################################

variable "config" {

  description = "AWS Config recorder configuration."

  type = object({

    name = optional(string, "default")
    recording_all_supported_resources = optional(bool, true)
    include_global_resource_types = optional(bool, true)
    resource_types = optional(list(string), [])
    role_arn = string
    s3_bucket_name = string
    s3_key_prefix = optional(string)
    sns_topic_arn = optional(string)
    delivery_frequency = optional(string, "TwentyFour_Hours")
    enabled = optional(bool, true)
    tags = optional(map(string), {})

  })

}


#########################################################
# COMMON TAGS
#########################################################

variable "tags" {

  description = "Common tags for AWS Config resources."

  type = map(string)

  default = {}

}
