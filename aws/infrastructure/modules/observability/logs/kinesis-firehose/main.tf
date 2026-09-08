#########################################################
# KINESIS DATA FIREHOSE DELIVERY STREAMS
#########################################################

resource "aws_kinesis_firehose_delivery_stream" "this" {

  for_each = var.firehose_streams

  name = coalesce(
    each.value.name,
    each.key
  )

  destination = each.value.destination

  #######################################################
  # S3 DESTINATION
  #######################################################

  dynamic "extended_s3_configuration" {

    for_each = each.value.destination == "extended_s3" ? [1] : []

    content {

      role_arn = var.iam_role_arns[each.key]

      bucket_arn = each.value.bucket_arn

      buffering_size = each.value.buffer_size

      buffering_interval = each.value.buffer_interval

      compression_format = each.value.compression_format

      error_output_prefix = each.value.error_output_prefix

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
