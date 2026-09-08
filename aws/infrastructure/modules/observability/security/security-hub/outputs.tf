#########################################################
# SECURITY HUB ACCOUNT
#########################################################

output "cloudwatch_security_hub_account_id" {

  description = "AWS Security Hub account resource ID."

  value = try(
    aws_securityhub_account.this[0].id,
    null
  )

}


#########################################################
# SECURITY HUB ARN
#########################################################

output "cloudwatch_security_hub_arn" {

  description = "AWS Security Hub account ARN."

  value = try(
    aws_securityhub_account.this[0].arn,
    null
  )

}


#########################################################
# AWS FOUNDATIONAL STANDARD
#########################################################

output "cloudwatch_aws_foundational_standard_id" {

  description = "AWS Foundational Security Best Practices standard subscription ID."

  value = try(
    aws_securityhub_standards_subscription.aws_foundational[0].id,
    null
  )

}


#########################################################
# CIS STANDARD
#########################################################

output "cloudwatch_cis_standard_id" {

  description = "CIS AWS Foundations Benchmark standard subscription ID."

  value = try(
    aws_securityhub_standards_subscription.cis[0].id,
    null
  )

}


#########################################################
# PCI DSS STANDARD
#########################################################

output "cloudwatch_pci_dss_standard_id" {

  description = "PCI DSS standard subscription ID."

  value = try(
    aws_securityhub_standards_subscription.pci_dss[0].id,
    null
  )

}
