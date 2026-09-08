variable "elastic_ips" {
  description = "Elastic IP definitions"

  type = map(object({
    name = string
  }))
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)
  default     = {}
}
