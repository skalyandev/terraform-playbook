#########################################################
# TARGET GROUP ATTACHMENTS
#########################################################

variable "target_group_attachments" {

  description = "Target Group Attachments"

  type = map(object({

    target_group = string
    instance     = string
    port         = number

  }))

}

#########################################################
# TARGET GROUP ARNS
#########################################################

variable "target_group_arns" {

  description = "Target Group ARNs"
  type = map(string)

}

#########################################################
# EC2 INSTANCE IDS
#########################################################

variable "instance_ids" {

  description = "EC2 Instance IDs"
  type = map(string)

}
