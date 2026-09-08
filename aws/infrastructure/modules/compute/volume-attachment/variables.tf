variable "volume_attachments" {

  description = "EBS Volume Attachments"

  type = map(object({

    instance = string
    volume = string
    device_name = string
    force_detach = optional(bool, true)
    skip_destroy = optional(bool, false)
  }))
}

variable "instance_ids" {

  description = "EC2 Instance IDs"
  type = map(string)

}

variable "volume_ids" {

  description = "EBS Volume IDs"
  type = map(string)

}
