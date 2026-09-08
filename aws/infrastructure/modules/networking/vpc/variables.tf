variable "name" {
  description = "VPC Name"
  type        = string
}

variable "cidr_block" {
  description = "VPC CIDR Block"
  type        = string

  validation {
    condition     = can(cidrhost(var.cidr_block, 0))
    error_message = "Invalid CIDR block."
  }
}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS Hostnames"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "VPC Instance Tenancy"
  type        = string
  default     = "default"
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)
  default     = {}
}
