#########################################################
# EKS CLUSTERS
#########################################################

variable "eks_clusters" {

  description = "EKS Cluster Configuration"

  type = map(object({

    version = string

    role = string

    security_groups = list(string)

    endpoint_private_access = optional(bool, true)

    endpoint_public_access = optional(bool, false)

    enabled_cluster_log_types = optional(list(string), [])

    tags = optional(map(string), {})

  }))

}

#########################################################
# ROLE ARNS
#########################################################

variable "role_arns" {

  description = "IAM Role ARNs"

  type = map(string)

}

#########################################################
# PRIVATE SUBNET IDS
#########################################################

variable "private_subnet_ids" {

  description = "Private Subnet IDs"

  type = map(string)

}

#########################################################
# SECURITY GROUP IDS
#########################################################

variable "security_group_ids" {

  description = "Security Group IDs"

  type = map(string)

}

#########################################################
# COMMON TAGS
#########################################################

variable "tags" {

  description = "Common Tags"

  type = map(string)

}
