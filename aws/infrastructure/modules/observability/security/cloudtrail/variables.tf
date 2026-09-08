#########################################################
# CLOUDTRAIL
#########################################################

variable "trails" {

  description = "CloudTrail trail configurations."

  type = map(object({

    #####################################################
    # TRAIL
    #####################################################

    name = optional(string)

    s3_bucket_name = string

    s3_key_prefix = optional(string)

    #####################################################
    # MULTI-REGION
    #####################################################

    include_global_service_events = optional(bool, true)

    is_multi_region_trail = optional(bool, true)

    #####################################################
    # LOG VALIDATION
    #####################################################

    enable_log_file_validation = optional(bool, true)

    #####################################################
    # ORGANIZATION
    #####################################################

    is_organization_trail = optional(bool, false)

    #####################################################
    # CLOUDWATCH LOGS
    #####################################################

    cloudwatch_log_group_arn = optional(string)

    cloudwatch_logs_role_arn = optional(string)

    #####################################################
    # MANAGEMENT EVENTS
    #####################################################

    include_management_events = optional(bool, true)

    read_write_type = optional(string, "All")

    #####################################################
    # TAGS
    #####################################################

    tags = optional(map(string), {})

  }))

}


#########################################################
# COMMON TAGS
#########################################################

variable "tags" {

  description = "Common tags applied to CloudTrail."

  type = map(string)

  default = {}

}
