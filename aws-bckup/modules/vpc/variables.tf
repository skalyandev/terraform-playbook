variable "name" {
  type  = string
}

variable "vpc_cidr_range" {
  type  = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
