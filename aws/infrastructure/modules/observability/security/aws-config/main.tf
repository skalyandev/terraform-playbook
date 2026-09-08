#########################################################
# AWS CONFIG DELIVERY CHANNEL
#########################################################

resource "aws_config_delivery_channel" "this" {

  count = var.config.enabled ? 1 : 0

  name = var.config.name

  s3_bucket_name = var.config.s3_bucket_name

  s3_key_prefix = var.config.s3_key_prefix

  sns_topic_arn = var.config.sns_topic_arn

  snapshot_delivery_properties {

    delivery_frequency = var.config.delivery_frequency

  }

}


#########################################################
# AWS CONFIG RECORDER
#########################################################

resource "aws_config_configuration_recorder" "this" {

  count = var.config.enabled ? 1 : 0

  name = var.config.name

  role_arn = var.config.role_arn

  recording_group {

    all_supported = var.config.recording_all_supported_resources

    include_global_resource_types = ( var.config.include_global_resource_types )

    resource_types = ( var.config.recording_all_supported_resources ? null : var.config.resource_types )

  }

}


#########################################################
# AWS CONFIG RECORDER STATUS
#########################################################

resource "aws_config_configuration_recorder_status" "this" {

  count = var.config.enabled ? 1 : 0

  name = aws_config_configuration_recorder.this[0].name

  is_enabled = true

  depends_on = [ aws_config_delivery_channel.this ]

}
