#########################################################
# CURRENT AWS REGION
#########################################################

data "aws_region" "current" {}


#########################################################
# AWS SECURITY HUB
#########################################################

resource "aws_securityhub_account" "this" {

  count = var.security_hub.enabled ? 1 : 0

  auto_enable_controls = var.security_hub.auto_enable_controls

  enable_default_standards = false

  control_finding_generator = "STANDARD_CONTROL"

}


#########################################################
# AWS FOUNDATIONAL SECURITY BEST PRACTICES
#########################################################

resource "aws_securityhub_standards_subscription" "aws_foundational" {

  count = (
    var.security_hub.enabled &&
    var.security_hub.enable_aws_foundational_security_best_practices
  ) ? 1 : 0

  standards_arn = format(
    "arn:aws:securityhub:%s::standards/aws-foundational-security-best-practices/v/1.0.0",
    data.aws_region.current.name
  )

  depends_on = [
    aws_securityhub_account.this
  ]

}


#########################################################
# CIS AWS FOUNDATIONS BENCHMARK
#########################################################

resource "aws_securityhub_standards_subscription" "cis" {

  count = (
    var.security_hub.enabled &&
    var.security_hub.enable_cis_aws_foundations_benchmark
  ) ? 1 : 0

  standards_arn = format(
    "arn:aws:securityhub:%s::standards/cis-aws-foundations-benchmark/v/1.4.0",
    data.aws_region.current.name
  )

  depends_on = [
    aws_securityhub_account.this
  ]

}


#########################################################
# PCI DSS
#########################################################

resource "aws_securityhub_standards_subscription" "pci_dss" {

  count = (
    var.security_hub.enabled &&
    var.security_hub.enable_pci_dss
  ) ? 1 : 0

  standards_arn = format(
    "arn:aws:securityhub:%s::standards/pci-dss/v/3.2.1",
    data.aws_region.current.name
  )

  depends_on = [
    aws_securityhub_account.this
  ]

}


