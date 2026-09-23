#########################################################
# LOCAL VALUES
#########################################################

locals {
  common_tags = merge(
    var.tags,
    {
      ManagedBy   = "terraform"
      CostControl = "anomaly-detection"
    }
  )
}
