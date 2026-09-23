variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "associate_public_ip_address" {
  type = bool
  default = false
}

variable "tags" {
  type = map(string)
}

#Cloud Init values
variable "bastion_ssh_key_1" {
  type = string
}

variable "bastion_ssh_key_2" {
  type = string
}

#aws IAM 
variable "instance_profile_name" {
  type = string
}

#ALB SEC GRP ID
variable "alb_sg_id" {
  type = string
}



