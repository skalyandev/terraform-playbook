#########################################################
# S3 BUCKET IDS
#########################################################

output "bucket_ids" {

  description = "S3 bucket IDs."

  value = {
    for k, v in aws_s3_bucket.this :
    k => v.id
  }

}


#########################################################
# S3 BUCKET NAMES
#########################################################

output "bucket_names" {

  description = "S3 bucket names."

  value = {
    for k, v in aws_s3_bucket.this :
    k => v.bucket
  }

}


#########################################################
# S3 BUCKET ARNS
#########################################################

output "bucket_arns" {

  description = "S3 bucket ARNs."

  value = {
    for k, v in aws_s3_bucket.this :
    k => v.arn
  }

}


#########################################################
# S3 BUCKET REGIONAL DOMAINS
#########################################################

output "bucket_regional_domains" {

  description = "S3 bucket regional domain names."

  value = {
    for k, v in aws_s3_bucket.this :
    k => v.bucket_regional_domain_name
  }

}


#########################################################
# S3 BUCKET HOSTED ZONE IDS
#########################################################

output "bucket_hosted_zone_ids" {

  description = "S3 bucket hosted zone IDs."

  value = {
    for k, v in aws_s3_bucket.this :
    k => v.hosted_zone_id
  }

}
