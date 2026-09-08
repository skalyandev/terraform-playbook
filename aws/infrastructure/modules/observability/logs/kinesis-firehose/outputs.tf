#########################################################
# FIREHOSE DELIVERY STREAM IDS
#########################################################

output "firehose_stream_ids" {

  description = "Kinesis Data Firehose delivery stream IDs."

  value = {
    for k, v in aws_kinesis_firehose_delivery_stream.this :
    k => v.id
  }

}


#########################################################
# FIREHOSE DELIVERY STREAM ARNS
#########################################################

output "firehose_stream_arns" {

  description = "Kinesis Data Firehose delivery stream ARNs."

  value = {
    for k, v in aws_kinesis_firehose_delivery_stream.this :
    k => v.arn
  }

}


#########################################################
# FIREHOSE DELIVERY STREAM NAMES
#########################################################

output "firehose_stream_names" {

  description = "Kinesis Data Firehose delivery stream names."

  value = {
    for k, v in aws_kinesis_firehose_delivery_stream.this :
    k => v.name
  }

}
