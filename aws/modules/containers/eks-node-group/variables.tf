#########################################################
# EKS NODE GROUPS
#########################################################

variable "eks_node_groups" {

  description = "EKS Managed Node Groups"

  type = map(object({

    cluster = string
    role = string
    subnet_type = string
    instance_types = list(string)
    capacity_type = string
    ami_type = string
    disk_size = number
    scaling = object({
      desired = number
      minimum = number
      maximum = number
    })

    labels = optional(map(string), {})
    tags = optional(map(string), {})

  }))

}

#########################################################
# CLUSTER NAMES
#########################################################

variable "cluster_names" {

  type = map(string)

}

#########################################################
# ROLE ARNS
#########################################################

variable "role_arns" {

  type = map(string)

}

#########################################################
# PRIVATE SUBNET IDS
#########################################################

variable "private_subnet_ids" {

  type = map(string)

}

#########################################################
# COMMON TAGS
#########################################################

variable "tags" {

  type = map(string)

}
