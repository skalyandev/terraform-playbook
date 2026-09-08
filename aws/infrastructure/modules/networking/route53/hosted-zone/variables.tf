variable "domain_name" {
  description = "Fully qualified domain name for the public hosted zone."
  type        = string
}

variable "comment" {
  description = "Optional comment for the hosted zone."
  type        = string
  default     = "Managed by Terraform"
}

variable "tags" {
  description = "Tags applied to the hosted zone."
  type        = map(string)
  default     = {}
}
