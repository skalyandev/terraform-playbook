#########################################################
# AWS CONFIG RECORDER ID
#########################################################

output "awsconfig_configuration_recorder_id" {

  description = "AWS Config configuration recorder ID."

  value = try(
    aws_config_configuration_recorder.this[0].id,
    null
  )

}


#########################################################
# AWS CONFIG RECORDER NAME
#########################################################

output "awsconfig_configuration_recorder_name" {

  description = "AWS Config configuration recorder name."

  value = try(
    aws_config_configuration_recorder.this[0].name,
    null
  )

}


#########################################################
# AWS CONFIG DELIVERY CHANNEL ID
#########################################################

output "awsconfig_delivery_channel_id" {

  description = "AWS Config delivery channel ID."

  value = try(
    aws_config_delivery_channel.this[0].id,
    null
  )

}


#########################################################
# AWS CONFIG DELIVERY CHANNEL NAME
#########################################################

output "awsconfig_delivery_channel_name" {

  description = "AWS Config delivery channel name."

  value = try(
    aws_config_delivery_channel.this[0].name,
    null
  )

}


#########################################################
# AWS CONFIG RECORDER STATUS
#########################################################

output "awsconfig_configuration_recorder_status_id" {

  description = "AWS Config configuration recorder status ID."

  value = try(
    aws_config_configuration_recorder_status.this[0].id,
    null
  )

}
