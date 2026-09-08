#########################################################
# CLOUDTRAIL IDS
#########################################################

output "cloudtrail_ids" {

  description = "CloudTrail trail IDs."

  value = {
    for k, v in aws_cloudtrail.this :
    k => v.id
  }

}


#########################################################
# CLOUDTRAIL ARNS
#########################################################

output "cloudtrail_arns" {

  description = "CloudTrail trail ARNs."

  value = {
    for k, v in aws_cloudtrail.this :
    k => v.arn
  }

}


#########################################################
# CLOUDTRAIL NAMES
#########################################################

output "cloudtrail_names" {

  description = "CloudTrail trail names."

  value = {
    for k, v in aws_cloudtrail.this :
    k => v.name
  }

}


#########################################################
# CLOUDTRAIL HOME REGIONS
#########################################################

output "cloudtrail_home_regions" {

  description = "CloudTrail trail home regions."

  value = {
    for k, v in aws_cloudtrail.this :
    k => v.home_region
  }

}
