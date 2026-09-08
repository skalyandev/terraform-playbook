#########################################################
# AWS CLOUDTRAIL
#########################################################

resource "aws_cloudtrail" "this" {

  for_each = var.trails

  #######################################################
  # TRAIL
  #######################################################

  name = coalesce(
    each.value.name,
    each.key
  )

  #######################################################
  # S3 DESTINATION
  #######################################################

  s3_bucket_name = each.value.s3_bucket_name

  s3_key_prefix = each.value.s3_key_prefix

  #######################################################
  # MULTI-REGION
  #######################################################

  is_multi_region_trail = (
    each.value.is_multi_region_trail
  )

  include_global_service_events = (
    each.value.include_global_service_events
  )

  #######################################################
  # LOG FILE VALIDATION
  #######################################################

  enable_log_file_validation = (
    each.value.enable_log_file_validation
  )

  #######################################################
  # ORGANIZATION TRAIL
  #######################################################

  is_organization_trail = (
    each.value.is_organization_trail
  )

  #######################################################
  # CLOUDWATCH LOGGING
  #######################################################

  cloud_watch_logs_group_arn = (
    each.value.cloudwatch_log_group_arn
  )

  cloud_watch_logs_role_arn = (
    each.value.cloudwatch_logs_role_arn
  )

  #######################################################
  # MANAGEMENT EVENTS
  #######################################################

  dynamic "event_selector" {

    for_each = (
      each.value.include_management_events ? [1] : [] )

    content {

      read_write_type = (
        each.value.read_write_type
      )

      include_management_events = (
        each.value.include_management_events
      )

    }

  }

  #######################################################
  # TAGS
  #######################################################

  tags = merge(

    var.tags,

    each.value.tags,

    {
      Name = coalesce(
        each.value.name,
        each.key
      )
    }

  )

}
