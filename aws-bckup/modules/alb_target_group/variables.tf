variable "vpc_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "bastion_instance_id" {
  type = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

