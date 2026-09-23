#########################################################
# EC2 INSTANCES
#########################################################

variable "instances" {

  description = "EC2 Instance Configuration"

  type = map(object({

    ami = string
    instance_type = string
    subnet = string
    security_groups = list(string)
    iam_instance_profile = optional(string)
    key_name = optional(string)
    associate_public_ip = optional(bool, false)
    monitoring = optional(bool, false)
    ebs_optimized = optional(bool, false)
    user_data_replace_on_change = optional(bool, false)
    disable_api_termination = optional(bool, false)
    user_data_file = optional(string)

    root_volume = optional(object({
   
      size = number
      type = string
      encrypted = optional(bool, true)
      delete_on_termination = optional(bool, true)
      iops = optional(number)
      throughput = optional(number)

    }))

    tags = optional(map(string), {})

  }))

}

#########################################################
# AMI IDS
#########################################################
variable "ami_ids" {

  type = map(string)

}

#########################################################
# SUBNET IDS
#########################################################
variable "subnet_ids" {

  type = map(string)

}

#########################################################
# SECURITY GROUP IDS
#########################################################
variable "security_group_ids" {

  type = map(string)

}

#########################################################
# INSTANCE PROFILE NAMES
#########################################################
variable "instance_profile_names" {

  type = map(string)

}

#########################################################
# COMMON TAGS
#########################################################
variable "tags" {

  type = map(string)

}
