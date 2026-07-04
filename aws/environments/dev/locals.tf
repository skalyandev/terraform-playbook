locals {

  name_prefix = "vodafone-dev"

  common_tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}
