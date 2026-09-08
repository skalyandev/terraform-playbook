variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "name" {
  description = "Internet Gateway Name"
  type        = string
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)
  default     = {}
}
