variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
