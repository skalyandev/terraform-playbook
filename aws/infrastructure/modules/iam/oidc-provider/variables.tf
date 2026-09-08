variable "cluster_oidc_issuers" {

  description = "OIDC issuer URLs from EKS clusters"
  type = map(string)

}

variable "tags" {

  description = "Common tags"
  type = map(string)
  default = {}

}
