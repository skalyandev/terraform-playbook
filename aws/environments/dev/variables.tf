################################################
# VPC VARIABLES
################################################
variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  type = string
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

################################################
# SUBNET VARIABLES
################################################
variable "subnets" {

  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    subnet_type             = string
    route_table             = string
  }))
}


#################################################
# ROUTE TABLE VARIABLES
#################################################
variable "route_tables" {

  type = map(object({
    route_type = string
  }))
}

##################################################
# ROUTES VARIABLES
##################################################
variable "routes" {

  type = map(object({

    route_table = string

    destination = string

    target_type = string

    target_name = optional(string)

  }))
}

###################################################
# SECURITY GRP VARIABLES
###################################################
variable "security_groups" {

  type = map(object({
    description = string
  }))
}

###################################################
# SECURITY GRP RULES VARIABLES
###################################################

variable "security_group_rules" {

  description = "Security Group Rules"
  type = any

}

####################################################
# IAM ROLES
####################################################

variable "roles" {

  type = map(object({

    description         = optional(string)
    trusted_services    = optional(list(string), [])
    trusted_aws_arns    = optional(list(string), [])
    max_session_duration = optional(number, 3600)
    path = optional(string, "/")
    tags = optional(map(string), {})

  }))
}

####################################################
# IAM POLICIES
####################################################

variable "policies" {

  type = map(object({

    description = optional(string)
    policy_file = string
    path = optional(string, "/")
    tags = optional(map(string), {})

  }))
}
####################################################
# ROLE POLICY ATTACHMENT
####################################################
variable "attachments" {

  type = map(object({

    role = string
    custom_policies = optional(list(string), [])
    managed_policies = optional(list(string), [])
  }))
}



####################################################
# INSTANCE PROFILES
####################################################

variable "instance_profiles" {

  type = map(object({

    role = string
    path = optional(string, "/")
    tags = optional(map(string), {})

  }))

}

#########################################################
# AMI VARIABLES
#########################################################
variable "amis" {

  type = any

}

#########################################################
# EC2 VARIABLES
#########################################################
variable "instances" {

  type = any

}

#########################################################
# EKS CLUSTERS VARIABLES
#########################################################
variable "eks_clusters" {
  
  type = any
  
}

#########################################################
# EKS NODE GRPS VARIABLES
#########################################################
variable "eks_node_groups" {
 
  type = any

}

#########################################################
# EKS ACCESS VARIABLES
#########################################################
variable "access_entries" {
  type = any
}
